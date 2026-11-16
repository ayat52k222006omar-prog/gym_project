import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/old_app/quiz_app/view/questions_page.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE4EBF5);
    return Scaffold(
      backgroundColor: backgroundColor, // نضيف لون الخلفية لل scaffold
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://img.freepik.com/premium-photo/education-support-help-concept-with-digital-blue-question-marks-dark-background-3d-rendering_670147-17868.jpg?w=740",
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quiz App",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Test your Knowledge",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Get.to(() => const QuestionsPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,// لون خلفية الزرار نفسه
                  foregroundColor: Colors.white,//لون الكتابة
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // حواف دائرية شكلها عصري
                  ),
                ),
                child:  Text(
                  "Start Quiz",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
