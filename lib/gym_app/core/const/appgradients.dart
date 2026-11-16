import 'package:flutter/material.dart';

class AppGradients {
  // تدرج الخلفية الأساسي الخاص بتطبيق PLATE (من أعلى لأسفل)
  static const LinearGradient plateBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
     Color.fromARGB(255, 152, 238, 224), // اللون الفاتح العلوي (تركواز فاتح)
      Color.fromRGBO(182, 239, 228, 1), // اللون المتوسط
      Color.fromARGB(255, 209, 238, 231), // اللون السفلي الدافئ
    ],
  );

  // إذا كنت تريد خلفية بلون تدرج آخر (مثلاً الوضع الغامق أو تدرجات بديلة)
  static const LinearGradient darkBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF05080B),
      Color(0xFF070B0F),
    ],
  );
}