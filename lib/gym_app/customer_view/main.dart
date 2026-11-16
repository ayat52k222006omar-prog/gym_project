import 'package:flutter/material.dart';
import 'package:get/get.dart';
// تأكدي من تعديل مسار استيراد الصفحة حسب مكانها في مشروعك
//import 'package:myfirstapp/gym/admin_view/admin_overview_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PLATE Admin Console',
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      // تشغيل صفحة الأوبزرفر كشاشة رئيسية
      home: LoginPage(),
    );
  }
}