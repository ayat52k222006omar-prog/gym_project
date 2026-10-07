import 'package:hive/hive.dart';

class HiveHelper {
  static const noteBox = "Note_Box";
  static const noteKey = "Note_Key";
  static List<String> myNotes = [];

  // جلب الملاحظات من Hive
  static Future<void> getNotes() async {
    var box = Hive.box(noteBox);
    // نقوم بالتحويل إلى List<String> لضمان توافق الأنواع
    var data = box.get(noteKey, defaultValue: <String>[]);
    myNotes = List<String>.from(data);
  }

  // إضافة ملاحظة جديدة وحفظها في الـ Box
  static Future<void> addNote(String note) async {
    myNotes.add(note);
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  // تعديل ملاحظة معينة
  static Future<void> updateNote(int index, String newText) async {
    myNotes[index] = newText;
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  // حذف ملاحظة واحدة
  static Future<void> deleteNote(int index) async {
    myNotes.removeAt(index);
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  // حذف كل الملاحظات دفعة واحدة
  static Future<void> deleteAllNotes() async {
    myNotes.clear();
    await Hive.box(noteBox).put(noteKey, myNotes);
  }
}