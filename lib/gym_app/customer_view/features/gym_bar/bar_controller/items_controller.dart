import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/model/items_model.dart';

class ItemsController extends GetxController {
  // متغير يحفظ الفئة المحددة حالياً
  String selectedCategory = "Shakes";

  int quantity = 1;

  // قائمة المنتجات بروابط صور سليمة 100% بدون أي أخطاء 404
  final List<ProductModel> products = [
    // ==================== BURGERS ====================
    ProductModel(
      productTitle: "Classic Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 120.0,
      rating: 4.8,
      reviewsCount: 120,
      description:
          "A delicious classic burger with beef, cheese and fresh vegetables.",
      category: "Shakes",
       subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Double Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 160.0,
      rating: 4.9,
      reviewsCount: 85,
      description:
          "Double beef patty with extra melted cheese and special sauce.",
      category: "Shakes", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Bacon Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 175.0,
      rating: 4.7,
      reviewsCount: 95,
      description:
          "Smoky beef burger topped with crispy bacon and cheddar cheese.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Chicken Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 110.0,
      rating: 4.5,
      reviewsCount: 60,
      description: "Crispy fried chicken breast with lettuce and creamy mayo.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Mushroom Swiss Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 155.0,
      rating: 4.8,
      reviewsCount: 110,
      description:
          "Juicy beef patty topped with sauteed mushrooms and Swiss cheese.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Spicy Jalapeno Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 140.0,
      rating: 4.6,
      reviewsCount: 70,
      description:
          "Fire up your taste buds with spicy jalapenos and hot sauce.",
      category: "Shakes", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "BBQ Smokehouse Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 165.0,
      rating: 4.9,
      reviewsCount: 130,
      description: "Drenched in rich BBQ sauce with onion rings and cheddar.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Cheeseburger Deluxe",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 130.0,
      rating: 4.4,
      reviewsCount: 50,
      description:
          "Simple yet delicious cheeseburger with double cheese slices.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Giant Tower Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 210.0,
      rating: 5.0,
      reviewsCount: 200,
      description:
          "Three layers of beef patties, bacon, and multiple cheese layers.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Egg Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 125.0,
      rating: 4.3,
      reviewsCount: 40,
      description: "Classic beef burger topped with a sunny-side-up fried egg.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Avocado Chicken Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 145.0,
      rating: 4.7,
      reviewsCount: 88,
      description:
          "Grilled chicken breast with fresh sliced avocado and herb dressing.",
      category: "Shakes", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Truffle Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 195.0,
      rating: 4.9,
      reviewsCount: 150,
      description:
          "Gourmet beef burger infused with luxury truffle mayo sauce.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Blue Cheese Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 160.0,
      rating: 4.5,
      reviewsCount: 65,
      description: "Bold flavored burger featuring sharp crumbly blue cheese.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Crispy Fish Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 135.0,
      rating: 4.4,
      reviewsCount: 45,
      description:
          "Golden fried fish fillet with tartar sauce and crisp lettuce.",
      category: "Shakes", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Veggie Delight Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 100.0,
      rating: 4.6,
      reviewsCount: 90,
      description: "Healthy plant-based patty with fresh garden vegetables.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Slider Trio Burgers",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 180.0,
      rating: 4.8,
      reviewsCount: 115,
      description: "Three mini sliders with different gourmet meat toppings.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Black Bean Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 115.0,
      rating: 4.3,
      reviewsCount: 35,
      description:
          "Spicy black bean and corn patty packed with wholesome flavor.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Breakfast Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 140.0,
      rating: 4.7,
      reviewsCount: 75,
      description:
          "Beef patty served with hash browns, bacon, and maple syrup drizzle.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Monster Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 230.0,
      rating: 4.9,
      reviewsCount: 180,
      description:
          "Four massive beef patties for the hungariest eaters out there.",
      category: "Shakes", subtitle: '',
    ),
    ProductModel(
      productTitle: "Slider Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 90.0,
      rating: 4.5,
      reviewsCount: 55,
      description:
          "Compact, juicy mini burger perfect for a quick light snack.",
      category: "Shakes", subtitle: '',
    ),

    // ==================== Meals ====================
    ProductModel(
      productTitle: "Cheese Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 150.0,
      rating: 4.6,
      reviewsCount: 95,
      description:
          "Delicious cheesy pizza with fresh tomato sauce and mozzarella.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Pepperoni Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 180.0,
      rating: 4.9,
      reviewsCount: 140,
      description:
          "Loaded with spicy pepperoni slices and extra mozzarella cheese.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Margherita Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 130.0,
      rating: 4.7,
      reviewsCount: 80,
      description:
          "Traditional Italian pizza with fresh basil, tomatoes, and mozzarella.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "BBQ Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 190.0,
      rating: 4.8,
      reviewsCount: 110,
      description:
          "Grilled chicken chunks, red onions, cilantro, and tangy BBQ sauce.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Vegetarian Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 140.0,
      rating: 4.5,
      reviewsCount: 65,
      description:
          "Packed with bell peppers, olives, mushrooms, and fresh onions.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Meat Lovers Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 210.0,
      rating: 4.9,
      reviewsCount: 170,
      description: "Covered with pepperoni, sausage, beef, bacon, and ham.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Four Cheese Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 170.0,
      rating: 4.7,
      reviewsCount: 90,
      description:
          "A rich blend of mozzarella, parmesan, gorgonzola, and ricotta.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Hawaiian Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 160.0,
      rating: 4.2,
      reviewsCount: 50,
      description:
          "Sweet pineapple chunks combined with savory ham and cheese.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Seafood Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 220.0,
      rating: 4.8,
      reviewsCount: 75,
      description: "Topped with shrimp, calamari, garlic, and herbs.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Buffalo Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 185.0,
      rating: 4.8,
      reviewsCount: 105,
      description: "Spicy buffalo chicken breast with ranch dressing drizzle.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Mushroom Truffle Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 200.0,
      rating: 4.9,
      reviewsCount: 125,
      description: "Earthy wild mushrooms infused with exquisite truffle oil.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Supreme Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 195.0,
      rating: 4.7,
      reviewsCount: 95,
      description: "The ultimate mix of meats, veggies, and extra cheese.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Pesto Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 175.0,
      rating: 4.6,
      reviewsCount: 60,
      description: "Green basil pesto base topped with tender grilled chicken.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Calzone Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 165.0,
      rating: 4.5,
      reviewsCount: 55,
      description: "Folded pizza pocket stuffed with rich cheese and fillings.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Mexican Spicy Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 180.0,
      rating: 4.8,
      reviewsCount: 110,
      description: "Ground beef, jalapenos, onions, and spicy Mexican spices.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "White Garlic Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 155.0,
      rating: 4.4,
      reviewsCount: 45,
      description: "Creamy garlic white sauce with herbs and mozzarella.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Greek Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 160.0,
      rating: 4.6,
      reviewsCount: 70,
      description: "Feta cheese, black olives, tomatoes, and fresh spinach.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Double Pepperoni Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 190.0,
      rating: 4.9,
      reviewsCount: 150,
      description: "Double layers of crispy pepperoni for maximum flavor.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Ranch Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 185.0,
      rating: 4.7,
      reviewsCount: 85,
      description: "Smooth ranch dressing base with tender chicken and bacon.",
      category: "Meals", subtitle: '',
    ),
    ProductModel(
      productTitle: "Mini Pizza Combo",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 140.0,
      rating: 4.5,
      reviewsCount: 40,
      description: "Set of three mini personal pizzas with mixed toppings.",
      category: "Meals", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),

    // ==================== Supplements ====================
    ProductModel(
      productTitle: "Cold Mojito",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 45.0,
      rating: 4.9,
      reviewsCount: 60,
      description: "Refreshing cold mojito drink with mint and lime.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Fresh Orange Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 35.0,
      rating: 4.7,
      reviewsCount: 50,
      description: "100% fresh squeezed orange juice packed with vitamins.",
      category: "Supplements", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Admin Ahmed", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Iced Caramel Macchiato",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 55.0,
      rating: 4.8,
      reviewsCount: 90,
      description:
          "Cold espresso layered with vanilla milk and caramel drizzle.",
      category: "Supplements", subtitle: '',
      oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Barworker Omar", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Strawberry Smoothie",
      productImage:
          "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500",
      price: 50.0,
      rating: 4.6,
      reviewsCount: 70,
      description: "Thick and creamy blended strawberry fruit smoothie.",
      category: "Supplements", subtitle: '',
       oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Barworker Omar", // <-- مين اللي عدله (اختياري)
    ),

    ProductModel(
      productTitle: "Lemon Mint Cooler",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 40.0,
      rating: 4.7,
      reviewsCount: 55,
      description: "Zesty lemon juice blended with crushed fresh mint leaves.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Chocolate Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 60.0,
      rating: 4.8,
      reviewsCount: 100,
      description: "Rich chocolate thick milkshake topped with whipped cream.",
      category: "Supplements", subtitle: '',
       oldPrice: 140.0,          // <-- أضيفي السعر القديم هنا (اختياري)
      updatedBy: "Barworker Omar", // <-- مين اللي عدله (اختياري)
    ),
    ProductModel(
      productTitle: "Oreo Shake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 65.0,
      rating: 5.0,
      reviewsCount: 140,
      description:
          "Blended cookies and cream milkshake with crunchy Oreo bits.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Iced Spanish Latte",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 55.0,
      rating: 4.9,
      reviewsCount: 110,
      description: "Sweet condensed milk mixed with bold iced espresso shots.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Green Detox Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 45.0,
      rating: 4.4,
      reviewsCount: 40,
      description:
          "Healthy green juice with spinach, green apple, and cucumber.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Watermelon Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 35.0,
      rating: 4.7,
      reviewsCount: 65,
      description: "Super refreshing ice-cold natural watermelon juice.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Passion Fruit Mojito",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 50.0,
      rating: 4.8,
      reviewsCount: 80,
      description: "Exotic passion fruit flavored sparkling mojito drink.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Vanilla Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 55.0,
      rating: 4.5,
      reviewsCount: 50,
      description: "Classic creamy vanilla milkshake with a cherry on top.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Iced Americano",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 35.0,
      rating: 4.6,
      reviewsCount: 60,
      description:
          "Pure espresso shots poured over crystal clear ice and water.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Blueberry Smoothie",
      productImage:
          "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500",
      price: 55.0,
      rating: 4.7,
      reviewsCount: 75,
      description: "Antioxidant-rich wild blueberry blended smoothie.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Peach Ice Tea",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 40.0,
      rating: 4.6,
      reviewsCount: 55,
      description: "Chilled black tea infused with sweet natural peach flavor.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Avocado Honey Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 65.0,
      rating: 4.9,
      reviewsCount: 95,
      description: "Rich avocado blended with milk and organic wild honey.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Pomegranate Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 50.0,
      rating: 4.8,
      reviewsCount: 70,
      description: "Freshly pressed tart and sweet ruby red pomegranate juice.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Caramel Popcorn Shake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 70.0,
      rating: 4.9,
      reviewsCount: 120,
      description: "Unique milkshake blended with caramel popcorn and sauce.",
      category: "Supplements", subtitle: '',
    ),
    ProductModel(
      productTitle: "Sparkling Mineral Water",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 20.0,
      rating: 4.3,
      reviewsCount: 30,
      description: "Crisp and refreshing carbonated bottled mineral water.",
      category: "Supplements", subtitle: '',
    ),
  ];

  List<ProductModel> get filteredProducts {
    return products.where((p) => p.category == selectedCategory).toList();
  }

  // تغيير الفئة وتحديث الشاشة فوراً
  void changeCategory(String category) {
    selectedCategory = category;
    update(); 
  }

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}