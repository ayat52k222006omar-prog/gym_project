import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quiz_controller.dart';
import 'quiz_home_page.dart'; // تأكدي من مسار صفحة الهوم لو محتاجة ترجعي لها

class ResultPage extends StatelessWidget {
  final QuizController quizController; // استقبال الكنترولر عشان نجيب منه النتيجة الحقيقية

  const ResultPage({super.key, required this.quizController});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE4EBF5);
    
    // نجيب السكور الحقيقي من الكنترولر
    int finalScore = quizController.score;
    int totalQuestions = quizController.questions.length;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    getImageURLBasedonScore(finalScore),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Quiz Finished!",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Your Score",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "$finalScore / $totalQuestions",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  getmessageBasedonScore(finalScore),
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
  onPressed: () {
    Get.offAll(() => const QuizHomePage());
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  child: const Text(
    "Restart Quiz",
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // تم تصحيح الشروط لتتوافق مع الدرجات الصحيحة
  String getImageURLBasedonScore(int score) {
    if (score >= 5) {
      // لو الدرجة 5 أو 6 (ممتاز)
      return "https://lh3.googleusercontent.com/mC5XcaYPoH4ov-RBuqzAvhycBUwAVrEDRkNgoUI_NZxfJVYrbQ9O463bAQ9z5Oa8FpQbz4QM0Tb9ClG_oGWQSq5nK0rPJWKx=w1600-rj-nu-e365";
    } else if (score >= 3) {
      // لو الدرجة 3 أو 4 (جيد)
      return "https://tse4.mm.bing.net/th/id/OIP.Hw6LHhc2kJ1M3RD1F9MV2QHaK5?r=0&rs=1&pid=ImgDetMain&o=7&rm=3";
    } else {
      // لو الدرجة 1 أو 2 (محاولة أخرى)
      return "https://lh3.googleusercontent.com/VFGOlF34L1TLT2nck_olsDOCUTxUQ9NJRUlrusl9nkYij-GvUwpZo0qDBpzt0A2SUZ7oc9OUcMODOapt7FyJLckf2EOjWRu9rw=w1600-rj-nu-e365";
    }
  }

  String getmessageBasedonScore(int score) {
    if (score >= 5) {
      return "Awesome! You nailed it!";
    } else if (score >= 3) {
      return "Good try, almost there!";
    } else {
      return "Don't give up, try again!";
    }
  }
}