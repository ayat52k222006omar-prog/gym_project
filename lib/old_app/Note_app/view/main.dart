import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myfirstapp/old_app/Note_app/cubit/note_cubit.dart';
import 'package:myfirstapp/old_app/Note_app/hive_helper.dart';
import 'package:myfirstapp/old_app/Note_app/view/note_page.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.noteBox);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
      ),
      home: BlocProvider(
        
        create: (context) => NoteCubit()..getNotes(), 
        child: NotesScreen(),
      ),
    );
  }
}