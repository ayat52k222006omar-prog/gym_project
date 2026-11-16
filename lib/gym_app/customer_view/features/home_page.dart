import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/customer_view/features/check_in_out_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/check_in_slider.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/trainers_list_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/profile_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  late int _currentIndex;

  double crowdPercentage = 0.23;

  bool isCheckedIn = false;

  Color getProgressColor(double percentage) {
    if (percentage < 0.40) {
      return Color.fromARGB(255, 52, 189, 164); // أخضر للازدحام المنخفض جداً
    } else if (percentage < 0.70) {
      return const Color(0xffFF7F73); // برتقالي/وردي للازدحام المتوسط
    } else {
      return const Color(0xffE53935); // أحمر للازدحام العالي
    }
  }

  // دالة لتحديد وصف حالة الازدحام (Quiet / Moderate / Busy)
  String getCrowdStatus(double percentage) {
    if (percentage < 0.50) {
      return "Quiet";
    } else if (percentage < 0.80) {
      return "Moderate";
    } else {
      return "Busy";
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = 3; // الـ index يبدأ بـ 3 لأننا واقفين على صفحة الـ Coach
    _currentIndex = index;
    // ضرب النسبة في 100 وتقريبها لأقرب رقم صحيح
    int percentageInt = (crowdPercentage * 100).round();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 152, 238, 224),
              Color.fromRGBO(182, 239, 228, 1),
              Color.fromARGB(255, 209, 238, 231),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. الهيدر
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good evening",
                          style: TextStyle(
                            color: Color(0xff6B7886),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Ahmed",
                          style: TextStyle(
                            color: Color(0xff1D2733),
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Inter",
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 188, 245, 231),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1F9A85),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Live",
                            style: TextStyle(
                              color: Color(0xFF1F9A85),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      // كارت الازدحام الديناميكي
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "Right now at Zamalek Club",
                              style: TextStyle(
                                color: Color(0xff6B7886),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // الدائرة البيانية الديناميكية
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: CircularProgressIndicator(
                                    value:
                                        crowdPercentage, // تحديث مقدار ملء الدائرة تلقائياً
                                    strokeWidth: 8,
                                    backgroundColor: const Color(0xffE5E9EE),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      getProgressColor(
                                          crowdPercentage), // تغيير لون الدائرة تلقائياً
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "$percentageInt%", // نص النسبة المئوية المضروب في 100
                                      style: const TextStyle(
                                        color: Color(0xff1D2733),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Text(
                                      "crowd level",
                                      style: TextStyle(
                                        color: Color(0xff6B7886),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // شارة وصف حالة الازدحام
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: getProgressColor(crowdPercentage)
                                    .withAlpha(150),
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: Text(
                                getCrowdStatus(
                                    crowdPercentage), // تغيير الكلمة تلقائياً حسب النسبة
                                style: TextStyle(
                                  color: getProgressColor(crowdPercentage),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // زر السحب أو كارت الحضور
                      SimpleSlideToCheckIn(
                        onCheckInTriggered: () async{
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckInOutScreen()),
                          );
                         
                        },
                      ),
                      const SizedBox(height: 20),

                      // البطاقات السفلية
                      Row(
                        children: [
                          Expanded(
                            child: Container(height: 150,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [SizedBox(height: 30,),
                                  const Text(
                                    "Inside now",
                                    style: TextStyle(
                                      color: Color(0xff6B7886),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "$percentageInt people", // يتغير هو الآخر تلقائياً مع النسبة
                                    style:  TextStyle(
                                      color: getProgressColor(crowdPercentage),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(height: 150,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Column(
                              
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [  SizedBox(height: 30,),
                                  Text(
                                    "Next workout",
                                    style: TextStyle(
                                      color: Color(0xff6B7886),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Chest day",
                                    style: TextStyle(
                                      color: Color(0xff1D2733),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                       Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          'Weights log',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF102A33),
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WeightsScreen()),
                          );},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        title: const Text(
                          'My orders',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF102A33),
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                    ],
                  ),
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
              Get.off(() => const TrainersListPage());
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