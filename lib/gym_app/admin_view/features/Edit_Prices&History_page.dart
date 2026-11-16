import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/admin_view/features/gym&bar_page.dart';
import 'package:myfirstapp/gym_app/admin_view/features/usermanagement_page.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/bar_controller/items_controller.dart';
import 'package:myfirstapp/gym_app/admin_view/features/overview_page.dart';
import 'package:myfirstapp/gym_app/core/const/appgradients.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/model/items_model.dart';

// كونترولر خاص بإدارة الفلاتر، الكروت المفتوحة، وتعديل الأسعار
class EditPricesController extends GetxController {
  final ItemsController itemsController = Get.find<ItemsController>();

  var selectedRoleFilter = 'Everyone'.obs; // Everyone, Admin, Bar worker
  var expandedCardIds = <String>[].obs;
  var isDrawerOpen = false.obs;

  void changeFilter(String filter) {
    selectedRoleFilter.value = filter;
  }

  void toggleCardExpansion(String productId) {
    if (expandedCardIds.contains(productId)) {
      expandedCardIds.remove(productId);
    } else {
      expandedCardIds.add(productId);
    }
  }

  bool isExpanded(String productId) => expandedCardIds.contains(productId);

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  // فلترة المنتجات بناءً على الفئة المختارة (Everyone, Admin, Bar worker)
  List<ProductModel> get filteredProducts {
    final allProducts = itemsController.products;
    if (selectedRoleFilter.value == 'Admin') {
      return allProducts.where((p) => p.updatedBy != null && p.updatedBy!.toLowerCase().contains('admin')).toList();
    } else if (selectedRoleFilter.value == 'Bar worker') {
      return allProducts.where((p) => p.updatedBy != null && (p.updatedBy!.toLowerCase().contains('bar') || p.updatedBy!.toLowerCase().contains('omar'))).toList();
    }
    return allProducts; // Everyone
  }
}

class EditPricesPage extends StatelessWidget {
  EditPricesPage({super.key});

  final EditPricesController controller = Get.put(EditPricesController());
  final List<String> filters = ['Everyone', 'Admin', 'Bar worker'];

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
                  // الهيدر العلوي (زر القائمة + العنوان بجانبه)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
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
                            child: const Icon(Icons.menu, color: Color(0xFF1D2733), size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Edit Prices & History",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1D2733),
                            ),
                          ),
                        ),
                        const Icon(Icons.more_horiz, color: Color(0xFF1D2733)),
                      ],
                    ),
                  ),

                  // شريط الفلاتر الأفقية (Everyone, Admin, Bar worker)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final filter = filters[index];
                          return Obx(() {
                            bool isSelected = controller.selectedRoleFilter.value == filter;
                            return GestureDetector(
                              onTap: () => controller.changeFilter(filter),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF56C5B1) : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected ? Colors.transparent : const Color(0xFFCFDCD9),
                                  ),
                                ),
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected ? Colors.white : const Color(0xFF1D2733),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // قائمة المنتجات المفعلة بالفلتر
                  Expanded(
                    child: Obx(() {
                      final products = controller.filteredProducts;
                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            "No price history found for this filter.",
                            style: TextStyle(color: Color(0xFF6B7886), fontSize: 14),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: products.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _buildProductPriceCard(context, product);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // 🎯 القائمة الجانبية (Drawer Menu)
          Obx(() {
            if (!controller.isDrawerOpen.value) return const SizedBox.shrink();
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => controller.toggleDrawer(),
                  child: Container(
                    color: Colors.black.withOpacity(0.35),
                  ),
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
                            controller.toggleDrawer();
                            Get.to(() => AdminOverviewPage());
                          }
                        ),
                        _buildDrawerItem(
                          icon: Icons.group_outlined, 
                          title: "User Management", 
                          isSelected: false, 
                          onTap: () {
                            controller.toggleDrawer();
                            Get.to(() => UsersManagementPage());
                          }
                        ),
                        _buildDrawerItem(icon: Icons.person_outline, title: "Gym Occupancy", isSelected: false, onTap: () {}),
                        _buildDrawerItem(
                          icon: Icons.local_bar_outlined, 
                          title: "Gym & Bar", 
                          isSelected: false, 
                          onTap: () {
                            controller.toggleDrawer();
                            Get.to(() => GymBarPage());
                          }
                        ),
                        _buildDrawerItem(
                          icon: Icons.local_offer_outlined, 
                          title: "Price History", 
                          isSelected: true,
                          onTap: () => controller.toggleDrawer(),
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

  /// تصميم الكارت التفاعلي مع تفعيل زر الـ Edit لفتح نافذة التعديل
  Widget _buildProductPriceCard(BuildContext context, ProductModel product) {
    return Obx(() {
      bool expanded = controller.isExpanded(product.id);

      return GestureDetector(
        onTap: () => controller.toggleCardExpansion(product.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3ECEA)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          product.productTitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D2733),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF3F3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            product.category,
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7886),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 🎯 زر الـ Edit يفتح نافذة التعديل (Bottom Sheet) مطابقة للصورة
                  ElevatedButton(
                    onPressed: () => _showEditPriceBottomSheet(context, product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B5563),
                      minimumSize: const Size(64, 34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Current: ${product.price} EGP",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1D2733),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF6B7886),
                    size: 20,
                  ),
                ],
              ),

              // التفاصيل تظهر فقط عند الضغط على الكارت
              if (expanded) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Color(0xFFE3ECEA), height: 1),
                ),
                const SizedBox(height: 4),
                _detailRow("User", product.updatedBy ?? "Ahmed Fawzy · Bar worker"),
                const SizedBox(height: 6),
                _detailRow("Timestamp", "Today 14:20"),
                const SizedBox(height: 6),
                _detailRow("Price Change", "was ${product.oldPrice ?? 60} EGP"),
              ],
            ],
          ),
        ),
      );
    });
  }

  /// 🎯 نافذة Bottom Sheet لتعديل السعر مطابقة للشكل المطلوب
  void _showEditPriceBottomSheet(BuildContext context, ProductModel product) {
    var tempPrice = product.price.obs;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCFDCD9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Edit price · ${product.productTitle}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1D2733),
                ),
              ),
              const SizedBox(height: 20),
              
              // حقل تعديل السعر مع أزرار الزيادة والنقصان
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE3ECEA)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (tempPrice.value > 5) tempPrice.value -= 5;
                      },
                      icon: const Icon(Icons.remove, color: Color(0xFF6B7886)),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFE3ECEA)),
                      ),
                    ),
                    Obx(() => Text(
                      "${tempPrice.value.toInt()} EGP",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2733),
                      ),
                    )),
                    IconButton(
                      onPressed: () {
                        tempPrice.value += 5;
                      },
                      icon: const Icon(Icons.add, color: Color(0xFF6B7886)),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFE3ECEA)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // كارت التنبيه بالتغيير
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE3ECEA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      "${product.price.toInt()} EGP ➔ ${tempPrice.value.toInt()} EGP",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D2733),
                      ),
                    )),
                    const SizedBox(height: 4),
                    const Text(
                      "The bar worker will see: who edited, old and new price, and the time.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7886),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // أزرار الحفظ والإلغاء
              ElevatedButton(
                onPressed: () {
                  controller.itemsController.updateProductPrice(product.id, tempPrice.value, "Dr. Khaled");
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF4877B),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Save price",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFFCFDCD9)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2733),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF6B7886),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D2733),
          ),
        ),
      ],
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