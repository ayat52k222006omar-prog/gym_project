import 'package:flutter/material.dart';
class Whatsapptextstyle {
  // دالة ترجع ستايل التايتل
  static TextStyle titleTextStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  // دالة ترجع ستايل الرسالة
  static TextStyle msgTextStyle() {
    return const TextStyle(
      color: Colors.grey,
    );
  }
}