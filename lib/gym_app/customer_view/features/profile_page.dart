import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_application/gym/customer_view/weights.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/trainers_list_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/home_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int daysleft=28;
  late int _currentIndex;
  @override
  Widget build(BuildContext context) {
    var index = 3; // الـ index يبدأ بـ 3 لأننا واقفين على صفحة الـ Coach
    _currentIndex = index;
    return Scaffold(
      body: Container(
       height: double.infinity,
       width: double.infinity,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF102A33),
                      ),
                    ),
                    // زر الإعدادات فقط (تم إلغاء الـ 3 نقط)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF102A33),
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

             
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFFCCE8E3),
                      child: const Text(
                        'A',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE58872),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Ahmed Mohamed',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF102A33),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Member ID · 20418',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

          
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE89E8D).withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD3F2EC),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Color(0xFF2C8C77),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Days Left Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            daysleft.toString(),
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE58872),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'days left',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF102A33),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                     
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: daysleft / 100, 
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF38B29B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

               
                      const Text(
                        'Renews Dec 30, 2026',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ask the front desk to renew',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // 4. Quick Stats Cards (Visits, Workouts, Orders)
                Row(
                  children: [
                    _buildStatCard('12', 'Visits'),
                    const SizedBox(width: 10),
                    _buildStatCard('28', 'Workouts'),
                    const SizedBox(width: 10),
                    _buildStatCard('5', 'Orders'),
                  ],
                ),
                const SizedBox(height: 30),

                // 5. Body Measurements Section (Weight & Height)
                Row(
                  children: [
                    Expanded(
                      child: _buildMeasurementCard('Weight', '74.2 kg'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMeasurementCard('Height', '178 cm'), // استبدال الـ Bench PR بالـ Height
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // 6. Navigation Options List
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
                const SizedBox(height: 20),
              ],
            ),
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

  // ودجت كروت الإحصائيات الصغيرة (Visits, Workouts, Orders)
  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102A33),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت كروت القياسات (Weight, Height)
  Widget _buildMeasurementCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102A33),
            ),
          ),
        ],
      ),
    );
  }
}