import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_controller.dart';
import 'package:myfirstapp/old_app/quiz_app/view/result_page.dart';

// نربط الواجهة بالمنطق
class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState(); // ديمي علامة الأقواس العادية من غير نقطة منقوطة في النهاية لو جوه كلاس، أو الطريقة الصحيحة تحت:
}

class _QuestionsPageState extends State<QuestionsPage> {
  final quizController = QuizController();
  // اخد نسخة مالكونترولر عشان نستخدها هنا
  int questionIndex = 0; // مؤشر السؤال الحالى

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    questionIndex = quizController.questionIndex;
    const bgColor = Color(0xFFE4EBF5);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. شريط العنوان العلوي (زر الرجوع + العنوان)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر الرجوع بتصميم نيومورفيك مدور
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            offset: const Offset(-4, -4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black87),
                    ),
                  ),
                  const Text(
                    "Quiz App",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(width: 40), // لضبط توسيط العنوان
                ],
              ),

              const SizedBox(height: 25),

              // 2. شريط التقدم (Progress Bar & Percentage)
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: quizController.getProgress(),
                      minHeight: 8,
                      backgroundColor: bgColor,
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "${(quizController.getProgress() * 100).toInt()} %",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 3. كارد السؤال (بارز للخارج)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(8, 8),
                      blurRadius: 15,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      offset: const Offset(-8, -8),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Text(
                  quizController.questions[questionIndex].questionTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 4. خيارات الإجابات (توليد تلقائي للاختيارات بـ List.generate بدلاً من التكرار)
              ...List.generate(
                quizController.questions[questionIndex].answers.length,
                (index) {
                  String answerText =
                      quizController.questions[questionIndex].answers[index];
                  bool isSelected = quizController.selectedValue == answerText;

                  return GestureDetector(
                    onTap: () {
                      quizController.selectedValue = answerText;
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFD6E4F0) : bgColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: isSelected
                            ? [
                                // تأثير غاطس عند الاختيار
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(3, 3),
                                  blurRadius: 6,
                                  spreadRadius: -1,
                                ),
                              ]
                            : [
                                // تأثير بارز للاختيارات العادية
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  offset: const Offset(5, 5),
                                  blurRadius: 10,
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.9),
                                  offset: const Offset(-5, -5),
                                  blurRadius: 10,
                                ),
                              ],
                      ),
                      child: Text(
                        answerText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.blue.shade800 : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),

              const Spacer(),

              // 5. زر التالي (Next Button)
             SizedBox(
  height: 55,
  width: double.infinity,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: quizController.selectedValue == null
        ? null
        : () {
            // استبدلنا nextQuestion القديمة بالمنطق ده عشان يشوف الأسئلة خلصت ولا لسه
            bool hasMore = quizController.nextQuestion(); 
            
            if (hasMore) {
              // لو لسه فيه أسئلة، حدث الصفحة عشان يعرض السؤال الجديد
              setState(() {});
            } else {
              // لو الأسئلة خلصت، انطلق لصفحة النتيجة وابعت معاها الـ controller
              Get.to(() => ResultPage(quizController: quizController));
            }
          },
    child: Text(
      "Next",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: quizController.selectedValue == null
            ? Colors.grey
            : Colors.blueAccent,
      ),
    ),
  ),
)
             // const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}