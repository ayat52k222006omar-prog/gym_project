import 'package:myfirstapp/old_app/quiz_app/model/question_model.dart';



class QuizController {
  
  // 1. متغير لتخزين الإجابة التي اختارها المستخدم حالياً
  String? selectedValue;

  // 2. مؤشر السؤال الحالي (يبدأ من الصفر)
  int questionIndex = 0;

  // 3. قائمة الأسئلة الجديدة الخاصة بالبرمجة وتطوير التطبيقات
  final List<QuestionModel> questions = [
    QuestionModel(
      questionTitle: "What programming language is used for Flutter?",
      answers: ["Kotlin", "Dart", "Swift"],
      correctAnswer: "Dart",
    ),
    QuestionModel(
      questionTitle: "Which widget is used for repeating lists efficiently in Flutter?",
      answers: ["ListView.builder", "Column", "Container"],
      correctAnswer: "ListView.builder",
    ),
    QuestionModel(
      questionTitle: "What is the main building block of a Flutter app's UI?",
      answers: ["Activities", "Widgets", "Intents"],
      correctAnswer: "Widgets",
    ),
    QuestionModel(
      questionTitle: "Which company developed the Flutter framework?",
      answers: ["Apple", "Microsoft", "Google"],
      correctAnswer: "Google",
    ),
    QuestionModel(
      questionTitle: "What does OOP stand for in programming?",
      answers: [
        "Object Oriented Programming",
        "Online Open Process",
        "Ordered Output Program"
      ],
      correctAnswer: "Object Oriented Programming",
    ),
    QuestionModel(
      questionTitle: "Which widget is used to make a UI element scrollable?",
      answers: ["SingleChildScrollView", "SizedBox", "Padding"],
      correctAnswer: "SingleChildScrollView",
    ),
  ];

  // 4. دالة لحساب نسبة التقدم في الاختبار
  double getProgress() {
    return (questionIndex + 1) / questions.length;
  }
  // رقم السؤال على عدد الاسئلة

 bool nextQuestion() {
  checkAnswer(selectedValue!); // ابعت القيمة المختارة هنا
  selectedValue = null; // reset selected value
  
  if (questionIndex < questions.length - 1) {
    questionIndex++;
    return true; 
  } else {
    return false; 
  }
}
  int score = 0;

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == questions[questionIndex].correctAnswer) {
      score++;
    }
  }
}
