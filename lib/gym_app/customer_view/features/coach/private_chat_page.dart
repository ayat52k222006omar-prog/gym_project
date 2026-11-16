import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/trainers_list_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/home_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/profile_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart';

class PrivateChatPage extends StatefulWidget {
  final TrainerModel trainer;

  const PrivateChatPage({super.key, required this.trainer});

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  // تحديد الـ index الخاص بصفحة الكوتش ليتم تلوين الأيقونة الخاصة بها في الشريط السفلي
  late int _currentIndex;

  @override
  Widget build(BuildContext context) {
    var index = 3; // الـ index يبدأ بـ 3 لأننا واقفين على صفحة الـ Coach
    _currentIndex = index;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.plateBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // الهيدر العلوي (زر الرجوع + My coach + وزر الاتصال والثلاث نقاط)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // زر الرجوع لصفحة المدربين
                        Container(
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Get.back(); // العودة لصفحة لستة المدربين
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF1D2733),
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "My coach",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.phone, color: Color(0xFFF4877B), size: 20),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.more_horiz, color: Color(0xFF1D2733)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // كارت بيانات المدرب
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: const Color(0xFFF4877B).withOpacity(0.2),
                            child: Text(
                              widget.trainer.name[0],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF4877B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.trainer.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D2733),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${widget.trainer.specialization} · ${widget.trainer.status}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7886),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    // كارت الأداء (Bench Press وغيرها)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          _ProgressRow(exercise: "Bench Press", weight: "62.5 → 65 kg"),
                          Divider(height: 20, color: Color(0xFFF0F2F5)),
                          _ProgressRow(exercise: "Chest Press", weight: "45 → 50 kg"),
                          Divider(height: 20, color: Color(0xFFF0F2F5)),
                          _ProgressRow(exercise: "Incline DB", weight: "24 → 22 kg"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // رسالة من الكوتش
                    _buildChatBubble(
                      message: "Nice work today. Add 2.5 kg next week if the last set felt easy.",
                      isMe: false,
                    ),

                    // رسالة من اليوزر (رد)
                    _buildChatBubble(
                      message: "My shoulder feels tight on incline.",
                      isMe: true,
                    ),

                    // رسالة تانية من الكوتش
                    _buildChatBubble(
                      message: "Drop 2 kg and send me one set on video.",
                      isMe: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // خانة كتابة الرسائل (Type a message...)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: const TextStyle(color: Color(0xFF8C98A4)),
                    filled: true,
                    fillColor: const Color(0xFFF4F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Color(0xFFF4877B)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // شريط التنقل السفلي تم نقله للمكان الصحيح خارج الـ Column
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFF4877B),
          unselectedItemColor: const Color(0xFF8C98A4),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            // التنقل بناءً على الزرار المختار
            if (index == 0) {
              Get.off(() => const CustomerHome());
            } else if (index == 1) {
              Get.off(() => const WeightsScreen());
            } else if (index == 2) {
              Get.off(() => const BarPage());
            } else if (index == 3) {
              Get.off(() => const TrainersListPage());
            } else if (index == 4) {
              Get.off(() => const ProfileScreen());
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Train',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_rounded),
              label: 'Bar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Coach',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // ودجت رسائل الشات
  Widget _buildChatBubble({required String message, required bool isMe}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFFF4877B) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isMe ? Colors.white : const Color(0xFF1D2733),
            fontSize: 14,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

// ودجت صفوف التقدم في التمارين
class _ProgressRow extends StatelessWidget {
  final String exercise;
  final String weight;

  const _ProgressRow({required this.exercise, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          exercise,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1D2733),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          weight,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1D2733),
          ),
        ),
      ],
    );
  }
}