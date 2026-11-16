import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym/customer_view/core/const/AppGradients.dart';
import 'package:myfirstapp/gym/customer_view/gym_bar/bar_controller/barcart_controller.dart'; // استدعاء الكنترولر الموحد للبار
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_controller/barcart_controller.dart';
// استيراد باقي الصفحات الخاصة بشريط التنقل السفلي
import 'package:myfirstapp/gym_app/customer_view/features/home_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/weights_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_view/bar_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/coach/trainers_list_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/profile_page.dart';

class UserCartPage extends StatefulWidget {
  const UserCartPage({super.key});

  @override
  State<UserCartPage> createState() => _CartPageState();
}

class _CartPageState extends State<UserCartPage> {
  bool isOrderPlaced = false;
  
  // استخدام الـ BarcartController الموحد بدل القديم عشان المنتجات تسمع
  final BarcartController cartController = Get.find<BarcartController>();

  // تعريف متغير الـ Navigation Bar
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // الـ index يبدأ بـ 2 لأن صفحة السلة تابعة للـ Bar
    var index = 2; 
    _currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.plateBackground,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر العلوي
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isOrderPlaced ? "Order #214" : "My Cart",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2733),
                      ),
                    ),
                    if (isOrderPlaced)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2F6F0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "3 min",
                          style: TextStyle(
                            color: Color(0xFF2E7D59),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          cartController.clearCart();
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // المحتوى الأساسي للسلة
              Expanded(
                child: Obx(() {
                  if (cartController.items.isEmpty && !isOrderPlaced) {
                    return const Center(
                      child: Text(
                        "Your Cart is Empty",
                        style: TextStyle(fontSize: 16, color: Color(0xFF6B7886)),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        if (isOrderPlaced) ...[
                          _buildOrderTrackingCard(),
                          const SizedBox(height: 15),
                        ],

                        // قائمة المنتجات داخل السلة
                        ListView.builder(
                          itemCount: cartController.items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final cartItem = cartController.items[index];
                            bool isAvailable = cartItem.product.description != "Back at 6 PM";

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
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
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F6F6),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        cartItem.product.productImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => const Icon(
                                          Icons.local_drink_rounded,
                                          color: Color(0xFFF4877B),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.product.productTitle,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1D2733),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          isOrderPlaced
                                              ? "${cartItem.product.description?.split('·')[0] ?? ''}· Qty ${cartItem.quantity}"
                                              : cartItem.product.description ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isAvailable ? const Color(0xFF6B7886) : Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "EGP ${cartItem.total.toInt()}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D2733),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 10),

                        // كارت طريقة الدفع
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Payment",
                                style: TextStyle(
                                  color: Color(0xFF8C98A4),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "Pay at the gym",
                                style: TextStyle(
                                  color: Color(0xFF1D2733),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // زر تأكيد الطلب
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isOrderPlaced ? Colors.white : const Color(0xFFF4877B),
                              foregroundColor: isOrderPlaced ? const Color(0xFFF4877B) : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: isOrderPlaced
                                    ? const BorderSide(color: Color(0xFFF4877B), width: 1.5)
                                    : BorderSide.none,
                              ),
                            ),
                            onPressed: cartController.items.isEmpty && !isOrderPlaced
                                ? null
                                : () {
                                    setState(() {
                                      if (isOrderPlaced) {
                                        cartController.clearCart();
                                        isOrderPlaced = false;
                                      } else {
                                        isOrderPlaced = true;
                                      }
                                    });
                                  },
                            child: Text(
                              isOrderPlaced ? "Cancel order" : "Place Order · EGP ${cartController.subtotal.toInt()}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }),
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

  Widget _buildOrderTrackingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          _buildStepRow(title: "Placed", subtitle: "05:25 PM", isDone: true, isCurrent: false),
          _buildStepRow(title: "Preparing", subtitle: "Ready in about 3 min", isDone: false, isCurrent: true),
          _buildStepRow(title: "Ready for pickup", subtitle: "", isDone: false, isCurrent: false),
          _buildStepRow(title: "Picked up", subtitle: "", isDone: false, isCurrent: false, isLast: true),
        ],
      ),
    );
  }

  Widget _buildStepRow({
    required String title,
    required String subtitle,
    required bool isDone,
    required bool isCurrent,
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDone || isCurrent ? const Color(0xFFF4877B) : const Color(0xFFD2D6DC),
                  width: 2,
                ),
                color: isDone ? const Color(0xFFF4877B) : Colors.transparent,
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : isCurrent
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF4877B),
                            ),
                          ),
                        )
                      : null,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TestText(title, isCurrent),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: isCurrent ? const Color(0xFFF4877B) : const Color(0xFF8C98A4))),
                ],
              ],
            ),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 2, height: 24, color: const Color(0xFFE5E7EB)),
            ),
          ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget TestText(String title, bool isCurrent) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: isCurrent ? const Color(0xFFF4877B) : const Color(0xFF1D2733),
      ),
    );
  }
}