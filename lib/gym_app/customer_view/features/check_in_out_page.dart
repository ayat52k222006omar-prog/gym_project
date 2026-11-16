import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/trainers_list_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/home_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/profile_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart';

class CheckInOutScreen extends StatefulWidget {
  final int initialTab;
  const CheckInOutScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  late int _selectedTab; 
  bool _isAutoCheckOutOn = true;

  // تعريف متغير الـ Navigation Bar
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;

    // استخدام الطريقة التي طلبتِها لتحديد الـ index (يمكنك تغيير الرقم 3 حسب رقم الصفحة في النافيغيشن بار)
    var index = 3; 
    _currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryTurquoise = Color(0xFF5DBB9E);
    const Color darkText = Color(0xFF0F3036);
   
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 152, 238, 224),
              Color.fromRGBO(182, 239, 228, 1),
              Color.fromARGB(255, 209, 238, 231),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                
                // Header (Title & Close Button)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTab == 0 ? 'Check in' : 'Check out',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 20, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),

                // Segmented Tabs (Check in / Check out)
                Container(
                  height: 48,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedTab == 0 ? primaryTurquoise : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Check in',
                              style: TextStyle(
                                color: _selectedTab == 0 ? Colors.white : Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = 1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedTab == 1 ? primaryTurquoise : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Check out',
                              style: TextStyle(
                                color: _selectedTab == 1 ? Colors.white : Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 1. كارد الـ Auto Check-out
                GestureDetector(
                  onTap: () {
                    if (_selectedTab == 0) {
                      setState(() {
                        _selectedTab = 1;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Auto check-out',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            _selectedTab == 0
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _isAutoCheckOutOn ? primaryTurquoise : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _isAutoCheckOutOn ? 'On' : 'Off',
                                      style: TextStyle(
                                        color: _isAutoCheckOutOn ? Colors.white : Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                : Switch(
                                    value: _isAutoCheckOutOn,
                                    activeColor: primaryTurquoise,
                                    activeTrackColor: primaryTurquoise.withOpacity(0.4),
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.grey[300],
                                    onChanged: (val) {
                                      setState(() {
                                        _isAutoCheckOutOn = val;
                                      });
                                    },
                                  ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isAutoCheckOutOn
                              ? 'We use your location to check you out when you leave, and we will notify you after 2 hours.'
                              : 'Auto check-out is off. Remember to check out manually! We will notify you after 2 hours, then every 10 minutes.',
                          style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 2. الكارد الرئيسي (QR Code أو شاشة الخروج)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: _selectedTab == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.redAccent.shade100, width: 1.5),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Icon(Icons.qr_code_2, size: 150, color: Colors.black87),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Scan the code at the entrance',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('or', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() => _selectedTab = 1);
                                  },
                                  icon: const Icon(Icons.pin_drop, color: Colors.pinkAccent),
                                  label: const Text(
                                    'Use my location',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF434C58),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.fitness_center, size: 80, color: primaryTurquoise),
                              const SizedBox(height: 20),
                              const Text(
                                'You are currently checked in!',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkText),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Enjoy your workout session.',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() => _selectedTab = 0);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryTurquoise,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: const Text(
                                    'Check out now',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      
      // شريط التنقل السفلي
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

            // التنقل بين الصفحات باستخدام GetX
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
}