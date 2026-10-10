import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // تفعيل ربط Flutter قبل استدعاء أي كود async
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة مكتبة Hive
  await Hive.initFlutter();

  // // await Hive.openBox('box_name');

  runApp(const MyApp());
}