class QuestionModel {
  final String questionTitle; // نص السؤال
  final List<String> answers; // قائمة للاختيارات
  final String correctAnswer; // متغير نهائى يحفظ الاجابة الصح

  QuestionModel({ // الـ constructor
    required this.questionTitle,
    required this.answers,
    required this.correctAnswer,
  });
}