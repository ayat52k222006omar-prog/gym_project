import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_controller.dart';
import '../controller/cart_controller.dart';
import 'cart_page.dart';
import 'product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController controller = Get.put(ProductController());
  
  // استخدام Get.find بدلاً من Get.put لكي لا يتم إنشاء نسخة جديدة فارغة
  final CartController cartController = Get.find<CartController>();

  final List<Map<String, String>> categories = [
    {"icon": "🍔", "name": "Burgers"},
    {"icon": "🍕", "name": "Pizza"},
    {"icon": "🥤", "name": "Drinks"},
    {"icon": "🧁", "name": "Desserts"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 203, 129, 10),
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Evening",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Text(
              "Ayat Kamal🦦",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Get.to(() => const CartPage());
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search food...",
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(categories.length, (index) {
                final categoryName = categories[index]["name"]!;
                final isSelected = controller.selectedCategory == categoryName;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.changeCategory(categoryName);
                    });
                  },
                  child: Container(
                    width: 75,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(categories[index]["icon"]!,
                            style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 8),
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.selectedCategory,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = controller.filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailsPage(product: product));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.productImage,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3748),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${product.rating} (${product.reviewsCount})",
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${product.price} EGP",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              cartController.addProduct(product);
                              Get.snackbar(
                                "تم الإضافة",
                                "${product.productTitle} تمت إضافته للسلة",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black87,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 1),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => const CartPage());
          }
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 14,
                      minHeight: 14,
                    ),
                    child: Obx(() => Text(
                          '${cartController.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}