import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/features/Edit_Prices&History_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/usermanagement_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_controller/items_controller.dart';
import 'package:myfirstapp/gym_app/admin_view/features/overview_page.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/model/items_model.dart';

// كونترولر محلي لإدارة التبويبات، القائمة الجانبية، وحالة تفعيل البار
class GymBarScreenController extends GetxController {
  var selectedTab = 0.obs; // 0: Stock, 1: Ingredients, 2: Prices
  var isBarServiceActive = true.obs;
  var isDrawerOpen = false.obs;

  void changeTab(int tabIndex) {
    selectedTab.value = tabIndex;
  }

  void toggleBarService(bool value) {
    isBarServiceActive.value = value;
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }
}

class GymBarPage extends StatelessWidget {
  GymBarPage({super.key});

  final GymBarScreenController pageController = Get.put(GymBarScreenController());
  final ItemsController itemsController = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // المحتوى الأساسي للصفحة
          Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.plateBackground,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // 1. الهيدر العلوي (ثابت)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => pageController.toggleDrawer(),
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
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Gym & Bar",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D2733),
                            ),
                          ),
                        ),
                        const Icon(Icons.more_horiz, color: Color(0xFF1D2733)),
                      ],
                    ),
                  ),

                  // الأجزاء الثابتة في الأعلى (كارت تفعيل البار + التنبيه + أزرار التبويبات)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // كارت تفعيل أو إيقاف خدمة البار
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE3ECEA)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bar service",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D2733),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Only the admin can turn this on or off.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7886),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() => Switch(
                                    value: pageController.isBarServiceActive.value,
                                    onChanged: (val) => pageController.toggleBarService(val),
                                    activeColor: Colors.white,
                                    activeTrackColor: const Color(0xFFD9483B),
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFFCFDCD9),
                                  )),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // تنبيه إيقاف البار
                        Obx(() {
                          if (!pageController.isBarServiceActive.value) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEAE6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFFFD4CE)),
                              ),
                              child: const Text(
                                "The bar is off. The whole bar part is removed from the app for admins, bar workers and clients, including Price History in the menu and the Bar worker role.",
                                style: TextStyle(
                                  color: Color(0xFFD9483B),
                                  fontSize: 13.5,
                                  height: 1.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),

                        // أزرار التبويبات (تظهر فقط إذا كان البار شغاباً)
                        Obx(() {
                          if (!pageController.isBarServiceActive.value) {
                            return const SizedBox.shrink();
                          }
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3ECEA),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                _buildTabButton("Stock", 0),
                                _buildTabButton("Ingredients", 1),
                                _buildTabButton("Prices", 2),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // المحتوى الديناميكي للتبويبات (يأخذ المساحة المتبقية لضمان بقاء زر Edit prices ثابتاً بالأسفل)
                  Expanded(
                    child: Obx(() {
                      if (!pageController.isBarServiceActive.value) {
                        return const SizedBox.shrink();
                      }
                      int tab = pageController.selectedTab.value;
                      if (tab == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildStockView(),
                        );
                      } else if (tab == 1) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildIngredientsView(),
                        );
                      } else {
                        return _buildPricesViewWithFixedButton();
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),

          // القائمة الجانبية (Drawer Menu)
          Obx(() {
            if (!pageController.isDrawerOpen.value) return const SizedBox.shrink();
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => pageController.toggleDrawer(),
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
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
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Dr. Khaled", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text("Zamalek Club · Admin", style: TextStyle(fontSize: 11, color: Color(0xFF6B7886))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDrawerItem(
                          icon: Icons.dashboard_outlined,
                          title: "Overview",
                          isSelected: false,
                          onTap: () {
                            pageController.toggleDrawer();
                            Get.to(() => AdminOverviewPage());
                          },
                        ),
                        _buildDrawerItem(
                          icon: Icons.group_outlined,
                          title: "User Management",
                          isSelected: false,
                          onTap: () {
                            pageController.toggleDrawer();
                            Get.to(() => UsersManagementPage());
                          },
                        ),
                        _buildDrawerItem(icon: Icons.person_outline, title: "Gym Occupancy", isSelected: false, onTap: () {}),
                        _buildDrawerItem(
                          icon: Icons.local_bar_outlined,
                          title: "Gym & Bar",
                          isSelected: true,
                          onTap: () => pageController.toggleDrawer(),
                        ),
                        _buildDrawerItem(
                          icon: Icons.local_offer_outlined,
                          title: "Price History",
                          isSelected: false,
                          onTap: () {
                            pageController.toggleDrawer();
                            Get.to(() => EditPricesPage());
                          },
                        ),
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

  Widget _buildTabButton(String title, int index) {
    return Expanded(
      child: Obx(() {
        bool isSelected = pageController.selectedTab.value == index;
        return GestureDetector(
          onTap: () => pageController.changeTab(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : [],
            ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
                color: isSelected ? const Color(0xFF1D2733) : const Color(0xFF6B7886),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// 📦 تبويب المخزن (Stock)
  Widget _buildStockView() {
    return Obx(() {
      return ListView.separated(
        itemCount: itemsController.products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final ProductModel product = itemsController.products[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE3ECEA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1D2733),
                      ),
                    ),
                    Text(
                      "${product.stockQuantity} in stock",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF1D2733),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category: ${product.category} · ${product.storageLocation ?? 'Main Storage'}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7886),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: product.stockQuantity <= product.minStockAlert
                            ? const Color(0xFFFEF3E7)
                            : const Color(0xFFD6F3EC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        product.stockStatusLabel,
                        style: TextStyle(
                          color: product.stockQuantity <= product.minStockAlert
                              ? const Color(0xFFD97706)
                              : const Color(0xFF1F9A85),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  /// 🏷️ تبويب الأسعار (Prices) مع زر Edit prices ثابت في أسفل الشاشة دائمًا دون الحاجة للنزول لآخر القائمة[cite: 7]
  Widget _buildPricesViewWithFixedButton() {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: itemsController.products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final ProductModel product = itemsController.products[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE3ECEA)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1D2733),
                            ),
                          ),
                          Text(
                            "${product.price.toInt()} EGP",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF1D2733),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (index % 3 == 0) ? 0.8 : (index % 2 == 0) ? 0.4 : 0.6,
                          backgroundColor: const Color(0xFFF4F6F6),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF56C5B1)),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.updatedBy != null
                                ? "Edited today by ${product.updatedBy}"
                                : "Last edit 3 days ago",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7886),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD6F3EC),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Shared",
                              style: TextStyle(
                                color: Color(0xFF1F9A85),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
        // زر Edit prices الثابت أسفل القائمة تماماً[cite: 7]
        Container(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Get.to(() => EditPricesPage()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4B5563),
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Edit prices",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// تبويب المكونات (Ingredients)
  Widget _buildIngredientsView() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildIngredientCard(
          title: "Whey protein",
          subtitle: "Per shake: 30 g",
          progress: 0.85,
          valueText: "4.2 kg",
          statusLabel: "OK",
          statusColor: const Color(0xFF2E7D59),
          statusBg: const Color(0xFFD6F3EC),
        ),
        const SizedBox(height: 10),
        _buildIngredientCard(
          title: "Whole milk",
          subtitle: "Per shake: 250 ml",
          progress: 0.95,
          valueText: "9 L",
          statusLabel: "OK",
          statusColor: const Color(0xFF2E7D59),
          statusBg: const Color(0xFFD6F3EC),
        ),
      ],
    );
  }

  Widget _buildIngredientCard({
    required String title,
    required String subtitle,
    required double progress,
    required String valueText,
    required String statusLabel,
    required Color statusColor,
    required Color statusBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE3ECEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1D2733),
                ),
              ),
              Text(
                valueText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1D2733),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7886),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF4F6F6),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF56C5B1)),
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF56C5B1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF1D2733),
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF1D2733),
              ),
            ),
          ],
        ),
      ),
    );
  }
}