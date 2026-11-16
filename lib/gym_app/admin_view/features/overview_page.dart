import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/features/Edit_Prices&History_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/gym&bar_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/usermanagement_page.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
// استوردي باقي الصفحات هنا لو حابة تربطي القائمة الجانبية بها
// import 'users_list_page.dart';
// import 'bar_page.dart';

class AdminOverviewController extends GetxController {
  // للتحكم في فتح وغلق القائمة الجانبية (Drawer)
  var isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }
}

class AdminOverviewPage extends StatelessWidget {
  AdminOverviewPage({super.key});

  final AdminOverviewController controller = Get.put(AdminOverviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الصفحة الأساسية
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.plateBackground,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // الهيدر العلوي
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // زر القائمة (Hamburger Menu)
                        GestureDetector(
                          onTap: () => controller.toggleDrawer(),
                          child: Container(
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
                            child: const Icon(Icons.menu, color: Color(0xFF1D2733), size: 22),
                          ),
                        ),
                        const Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                        // بادج الأدمن
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2F6F0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Admin",
                            style: TextStyle(
                              color: Color(0xFF2E7D59),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // محتوى الصفحة القابل للتمرير
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // 1. كارت GYM RIGHT NOW
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "GYM RIGHT NOW",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8C98A4),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2F6F0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "Light",
                                      style: TextStyle(
                                        color: Color(0xFF2E7D59),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: const [
                                  Text(
                                    "42",
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D2733),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "people inside · 42% of max",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF6B7886),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: 0.42,
                                  backgroundColor: const Color(0xFFF4F6F6),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF56C5B1)),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: const [
                                  Icon(Icons.arrow_drop_up, color: Color(0xFF2E7D59), size: 20),
                                  Text(
                                    "Increasing. Updated 1 minute ago.",
                                    style: TextStyle(
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

                        // 2. الكارتين الصغيرين بجانب بعض
                        Row(
                          children: [
                            Expanded(
                              child: _buildSmallMetricCard(
                                title: "Active bar orders",
                                count: "3",
                                subtitle: "Being prepared",
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildSmallMetricCard(
                                title: "Expiring soon",
                                count: "9",
                                subtitle: "Within 7 days",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // 3. قسم الاشتراكات التي تنتهي قريباً
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Subscriptions expiring soon",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D2733),
                                ),
                              ),
                              const SizedBox(height: 15),
                              _buildSubscriptionItem(name: "Sara Mahmoud", plan: "Quarterly", daysLeft: "2 days left"),
                              const Divider(height: 24, color: Color(0xFFF0F2F5)),
                              _buildSubscriptionItem(name: "Youssef Ammar", plan: "Monthly", daysLeft: "3 days left"),
                              const Divider(height: 24, color: Color(0xFFF0F2F5)),
                              _buildSubscriptionItem(name: "Mai Sherif", plan: "Half-yearly", daysLeft: "5 days left"),
                              const Divider(height: 24, color: Color(0xFFF0F2F5)),
                              _buildSubscriptionItem(name: "Osama Gamal", plan: "Monthly", daysLeft: "6 days left"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 4. قسم طلبات البار النشطة
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Active bar orders",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1D2733),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Protein shake × 2",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1D2733),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "Ordered by Karim Nabil",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7886),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2F6F0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Preparing",
                                      style: TextStyle(
                                        color: Color(0xFF2E7D59),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // القائمة الجانبية (Drawer Menu المخصصة)
          Obx(() {
            if (!controller.isDrawerOpen.value) return const SizedBox.shrink();
            return Stack(
              children: [
                // خلفية معتمة عند فتح القائمة
                GestureDetector(
                  onTap: () => controller.toggleDrawer(),
                  child: Container(
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
                // محتوى القائمة الجانبية
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 300,
                    height: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 52, 16, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الشعار
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, fontFamily: 'Inter'),
                            children: [
                              TextSpan(text: "PLATE ", style: TextStyle(color: Color(0xFF1D2733))),
                              TextSpan(text: "Admin", style: TextStyle(color: Color(0xFFF4877B))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // كارت البروفایل المصغر
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE3ECEa)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDE0dc),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "DK",
                                  style: TextStyle(color: Color(0xFFF4877B), fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Dr. Khaled", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text("Zamalek Club · Admin", style: TextStyle(fontSize: 11, color: Color(0xFF6B7886))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // عناصر التنقل في القائمة
                        _buildDrawerItem(
                          icon: Icons.dashboard_outlined,
                           title: "Overview",
                            isSelected: true,
                             onTap: () =>
                              controller.toggleDrawer()),
                        _buildDrawerItem(
                          icon: Icons.group_outlined,
                           title: "User Management", 
                           isSelected: false, 
                            onTap: () {
                              controller.toggleDrawer(); // لإغلاق القائمة الجانبية أولاً
                               Get.to(() => UsersManagementPage()); // الانتقال لصفحة إدارة المستخدمين
                             },),
                        _buildDrawerItem(icon: Icons.person_outline, title: "Gym Occupancy", isSelected: false, onTap: () {
                              controller.toggleDrawer(); // لإغلاق القائمة الجانبية أولاً
                              // الانتقال لصفحة إدارة المستخدمين
                             },),
                        _buildDrawerItem(
                          icon: Icons.local_bar_outlined,
                           title: "Gym & Bar", 
                           isSelected: false,
                         onTap: () {
                          controller.toggleDrawer(); // لإغلاق القائمة الجانبية أولاً
                            Get.to(() =>GymBarPage ());
                         },),
                        _buildDrawerItem(
                          icon: Icons.local_offer_outlined,
                           title: "Price History", 
                           isSelected: false, 
                          onTap: () {
                           controller.toggleDrawer();
                            Get.to(() => EditPricesPage());
                          }),
                        _buildDrawerItem(icon: Icons.credit_card_outlined, title: "Subscriptions & Policies", isSelected: false, onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSmallMetricCard({required String title, required String count, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7886),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2733),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8C98A4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionItem({required String name, required String plan, required String daysLeft}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2733),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              plan,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7886),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3E7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            daysLeft,
            style: const TextStyle(
              color: Color(0xFFD97706),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required bool isSelected, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE2F6F0) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF2E7D59) : const Color(0xFF1D2733), size: 22),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF2E7D59) : const Color(0xFF1D2733),
              ),
            ),
          ],
        ),
      ),
    );
  }
}