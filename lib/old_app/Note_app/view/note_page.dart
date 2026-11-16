import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfirstapp/old_app/Note_app/cubit/note_cubit.dart';
import 'package:myfirstapp/old_app/Note_app/hive_helper.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

 
  final TextEditingController _noteController = TextEditingController();

  
  void _showNoteDialog(BuildContext context, {int? index, String? initialText}) {
    final cubit = context.read<NoteCubit>();

    if (initialText != null) {
      _noteController.text = initialText;
    } else {
      _noteController.clear();
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            index == null ? "New Note" : "Edit Note",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _noteController,
            style: const TextStyle(color: Colors.white),
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Write your idea here...",
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFF2C2C2E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (_noteController.text.isNotEmpty) {
                  if (index == null) {
                    // استدعاء الكوبيت للإضافة
                    cubit.addNote(_noteController.text);
                  } else {
                    // استدعاء الكوبيت للتعديل
                    cubit.updateNote(index, _noteController.text);
                  }
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر (العنوان، اسمك، وزرار Clear All)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFFB7B2), Color(0xFFA9DEF9), Color(0xFFE4C1F9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Text(
                          "Capture Ideas",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFFB7B2), Color(0xFFA9DEF9), Color(0xFFE4C1F9)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Text(
                          "Hello Ayat 🦦🤺",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // زرار Clear All لترتيب ومسح الكل
                  if (HiveHelper.myNotes.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        cubit.clearAllNotes();
                      },
                      icon: const Icon(Icons.delete_sweep, color: Colors.redAccent, size: 20),
                      label: const Text(
                        "Clear All",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // شبكة عرض النوتات (GridView) مع استخدام BlocBuilder لتحديث الشاشة تلقائياً
              Expanded(
                child: BlocBuilder<NoteCubit, NoteState>(
                  builder: (context, state) {
                    if (HiveHelper.myNotes.isEmpty) {
                      return const Center(
                        child: Text(
                          "No notes yet, tap + to add one!",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        itemCount: HiveHelper.myNotes.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _showNoteDialog(
                                context,
                                index: index,
                                initialText: HiveHelper.myNotes[index],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _getCardColors(index),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Note ${index + 1}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.deleteNote(index);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          size: 18,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Text(
                                      HiveHelper.myNotes[index],
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // زر إضافة نوتة 
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _showNoteDialog(context),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

// ألوان الكاردات المتدرجة
List<Color> _getCardColors(int index) {
  switch (index % 5) {
    case 0:
      return [const Color(0xFFFFE5EC), const Color(0xFFFFC2D1)];
    case 1:
      return [const Color(0xFFE2F0CB), const Color(0xFFB5EAD7)];
    case 2:
      return [const Color(0xFFFFDAC1), const Color(0xFFFFB7B2)];
    case 3:
      return [const Color(0xFFD0F4DE), const Color(0xFFA9DEF9)];
    default:
      return [const Color(0xFFE4C1F9), const Color(0xFFF6DFEB)];
  }
}