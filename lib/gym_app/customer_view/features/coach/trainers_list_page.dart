import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/private_chat_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/home_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/profile_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart'; // استيراد صفحة البار للربط

class TrainerModel {
  final String name;
  final String specialization;
  final String imageUrl;
  final String status;

  TrainerModel({
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.status,
  });
}

class TrainersListPage extends StatefulWidget {
  const TrainersListPage({super.key});

  @override
  State<TrainersListPage> createState() => _TrainersListPageState();
}

class _TrainersListPageState extends State<TrainersListPage> {
  late int _currentIndex;

 

  @override
  Widget build(BuildContext context) {
    var index = 3; // الـ index يبدأ بـ 3 لأننا واقفين على صفحة الـ Coach
    _currentIndex = index;
    // قائمة تجريبية للمدربين
    final List<TrainerModel> trainers = [
      TrainerModel(
        name: "Mohamed Ali",
        specialization: "Strength & hypertrophy",
        imageUrl: "https://example.com/trainer1.png",
        status: "Online",
      ),
      TrainerModel(
        name: "Sarah Ahmed",
        specialization: "CrossFit & Weight Loss",
        imageUrl: "https://example.com/trainer2.png",
        status: "Online",
      ),
      TrainerModel(
        name: "Kamel Hassan",
        specialization: "Bodybuilding & Nutrition",
        imageUrl: "https://example.com/trainer3.png",
        status: "Offline",
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.plateBackground,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  "Our Trainers",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2733),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // لستة المدربين
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: trainers.length,
                  itemBuilder: (context, index) {
                    final trainer = trainers[index];
                    return GestureDetector(
                      onTap: () {
                        // الانتقال لصفحة الشات البرايفت وتمرير بيانات المدرب
                        Get.to(() => PrivateChatPage(trainer: trainer));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xFFF4877B).withOpacity(0.2),
                              child: Text(
                                trainer.name[0],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF4877B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trainer.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D2733),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    trainer.specialization,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6B7886),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: trainer.status == "Online"
                                    ? const Color(0xFFE2F6F0)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                trainer.status,
                                style: TextStyle(
                                  color: trainer.status == "Online"
                                      ? const Color(0xFF2E7D59)
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // شريط التنقل السفلي مع ربطه بصفحة البار وباقي الصفحات
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
            }
            if (index == 1) {
              Get.off(() => const WeightsScreen());
            }
            if (index == 2) {
              Get.off(() => const BarPage());
            }
            if (index == 3) {
              Get.off(() => _TrainersListPageState());
            }
            if (index == 4) {
              Get.off(() => const ProfileScreen());
            }
            // يمكنك إضافة باقي الصفحات هنا لو حابة (Home, Train, Profile)
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
}