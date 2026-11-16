import 'package:get/get.dart';
import 'package:myfirstapp/gym_app/customer_view/features/gym_bar/model/items_model.dart';

class ItemsController extends GetxController {
  // متغير يحفظ الفئة المحددة حالياً (مفعل كـ .obs لتحديث الواجهة أوتوماتيكياً)
  var selectedCategory = "Shakes".obs;

  var quantity = 1.obs;

  // قائمة المنتجات مع دعم خصائص المخزن (Stock & Inventory) وسجلات التعديل
  final RxList<ProductModel> products = <ProductModel>[
    // ==================== BURGERS ====================
    ProductModel(
      id: 'p1',
      productTitle: "Classic Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 120.0,
      rating: 4.8,
      reviewsCount: 120,
      description:
          "A delicious classic burger with beef, cheese and fresh vegetables.",
      category: "Shakes",
      subtitle: 'Classic',
      oldPrice: 140.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 15, // الكمية في المخزن
      minStockAlert: 5,  // الحد الأدنى للتنبيه
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p2',
      productTitle: "Double Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 160.0,
      rating: 4.9,
      reviewsCount: 85,
      description:
          "Double beef patty with extra melted cheese and special sauce.",
      category: "Shakes",
      subtitle: 'Double',
      oldPrice: 180.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 3, // ⚠️ قارب على النفاذ (Low Stock)
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p3',
      productTitle: "Bacon Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 175.0,
      rating: 4.7,
      reviewsCount: 95,
      description:
          "Smoky beef burger topped with crispy bacon and cheddar cheese.",
      category: "Shakes",
      subtitle: 'Bacon',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p4',
      productTitle: "Chicken Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 110.0,
      rating: 4.5,
      reviewsCount: 60,
      description: "Crispy fried chicken breast with lettuce and creamy mayo.",
      category: "Shakes",
      subtitle: 'Chicken',
      stockQuantity: 25,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p5',
      productTitle: "Mushroom Swiss Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 155.0,
      rating: 4.8,
      reviewsCount: 110,
      description:
          "Juicy beef patty topped with sauteed mushrooms and Swiss cheese.",
      category: "Shakes",
      subtitle: 'Mushroom',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p6',
      productTitle: "Spicy Jalapeno Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 140.0,
      rating: 4.6,
      reviewsCount: 70,
      description:
          "Fire up your taste buds with spicy jalapenos and hot sauce.",
      category: "Shakes",
      subtitle: 'Spicy',
      oldPrice: 150.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 8,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p7',
      productTitle: "BBQ Smokehouse Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 165.0,
      rating: 4.9,
      reviewsCount: 130,
      description: "Drenched in rich BBQ sauce with onion rings and cheddar.",
      category: "Shakes",
      subtitle: 'BBQ',
      stockQuantity: 14,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p8',
      productTitle: "Cheeseburger Deluxe",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 130.0,
      rating: 4.4,
      reviewsCount: 50,
      description:
          "Simple yet delicious cheeseburger with double cheese slices.",
      category: "Shakes",
      subtitle: 'Deluxe',
      stockQuantity: 18,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p9',
      productTitle: "Giant Tower Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 210.0,
      rating: 5.0,
      reviewsCount: 200,
      description:
          "Three layers of beef patties, bacon, and multiple cheese layers.",
      category: "Shakes",
      subtitle: 'Tower',
      stockQuantity: 6,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p10',
      productTitle: "Egg Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 125.0,
      rating: 4.3,
      reviewsCount: 40,
      description: "Classic beef burger topped with a sunny-side-up fried egg.",
      category: "Shakes",
      subtitle: 'Egg',
      stockQuantity: 11,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p11',
      productTitle: "Avocado Chicken Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 145.0,
      rating: 4.7,
      reviewsCount: 88,
      description:
          "Grilled chicken breast with fresh sliced avocado and herb dressing.",
      category: "Shakes",
      subtitle: 'Avocado',
      oldPrice: 155.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 9,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p12',
      productTitle: "Truffle Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 195.0,
      rating: 4.9,
      reviewsCount: 150,
      description:
          "Gourmet beef burger infused with luxury truffle mayo sauce.",
      category: "Shakes",
      subtitle: 'Truffle',
      stockQuantity: 7,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p13',
      productTitle: "Blue Cheese Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 160.0,
      rating: 4.5,
      reviewsCount: 65,
      description: "Bold flavored burger featuring sharp crumbly blue cheese.",
      category: "Shakes",
      subtitle: 'Blue Cheese',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p14',
      productTitle: "Crispy Fish Burger",
      productImage:
          "https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500",
      price: 135.0,
      rating: 4.4,
      reviewsCount: 45,
      description:
          "Golden fried fish fillet with tartar sauce and crisp lettuce.",
      category: "Shakes",
      subtitle: 'Fish',
      oldPrice: 145.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel( 
      id: 'p15',
      productTitle: "Veggie Delight Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 100.0,
      rating: 4.6,
      reviewsCount: 90,
      description: "Healthy plant-based patty with fresh garden vegetables.",
      category: "Shakes",
      subtitle: 'Veggie',
      stockQuantity: 16,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p16',
      productTitle: "Slider Trio Burgers",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 180.0,
      rating: 4.8,
      reviewsCount: 115,
      description: "Three mini sliders with different gourmet meat toppings.",
      category: "Shakes",
      subtitle: 'Sliders',
      stockQuantity: 8,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p17',
      productTitle: "Black Bean Burger",
      productImage:
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500",
      price: 115.0,
      rating: 4.3,
      reviewsCount: 35,
      description:
          "Spicy black bean and corn patty packed with wholesome flavor.",
      category: "Shakes",
      subtitle: 'Bean',
      stockQuantity: 13,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p18',
      productTitle: "Breakfast Burger",
      productImage:
          "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500",
      price: 140.0,
      rating: 4.7,
      reviewsCount: 75,
      description:
          "Beef patty served with hash browns, bacon, and maple syrup drizzle.",
      category: "Shakes",
      subtitle: 'Breakfast',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel( 
      id: 'p19',
      productTitle: "Monster Burger",
      productImage:
          "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
      price: 230.0,
      rating: 4.9,
      reviewsCount: 180,
      description:
          "Four massive beef patties for the hungariest eaters out there.",
      category: "Shakes",
      subtitle: 'Monster',
      stockQuantity: 4, // ⚠️ Low Stock
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p20',
      productTitle: "Slider Burger",
      productImage:
          "https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500",
      price: 90.0,
      rating: 4.5,
      reviewsCount: 55,
      description:
          "Compact, juicy mini burger perfect for a quick light snack.",
      category: "Shakes",
      subtitle: 'Slider',
      stockQuantity: 20,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),

    // ==================== Meals ====================
    ProductModel(
      id: 'p21',
      productTitle: "Cheese Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 150.0,
      rating: 4.6,
      reviewsCount: 95,
      description:
          "Delicious cheesy pizza with fresh tomato sauce and mozzarella.",
      category: "Meals",
      subtitle: 'Pizza',
      stockQuantity: 15,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p22',
      productTitle: "Pepperoni Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 180.0,
      rating: 4.9,
      reviewsCount: 140,
      description:
          "Loaded with spicy pepperoni slices and extra mozzarella cheese.",
      category: "Meals",
      subtitle: 'Pepperoni',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p23',
      productTitle: "Margherita Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 130.0,
      rating: 4.7,
      reviewsCount: 80,
      description:
          "Traditional Italian pizza with fresh basil, tomatoes, and mozzarella.",
      category: "Meals",
      subtitle: 'Margherita',
      stockQuantity: 18,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p24',
      productTitle: "BBQ Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 190.0,
      rating: 4.8,
      reviewsCount: 110,
      description:
          "Grilled chicken chunks, red onions, cilantro, and tangy BBQ sauce.",
      category: "Meals",
      subtitle: 'BBQ Chicken',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p25',
      productTitle: "Vegetarian Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 140.0,
      rating: 4.5,
      reviewsCount: 65,
      description:
          "Packed with bell peppers, olives, mushrooms, and fresh onions.",
      category: "Meals",
      subtitle: 'Veggie',
      stockQuantity: 14,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p26',
      productTitle: "Meat Lovers Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 210.0,
      rating: 4.9,
      reviewsCount: 170,
      description: "Covered with pepperoni, sausage, beef, bacon, and ham.",
      category: "Meals",
      subtitle: 'Meat',
      stockQuantity: 8,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(   
      id: 'p27',
      productTitle: "Four Cheese Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 170.0,
      rating: 4.7,
      reviewsCount: 90,
      description:
          "A rich blend of mozzarella, parmesan, gorgonzola, and ricotta.",
      category: "Meals",
      subtitle: 'Cheese',
      stockQuantity: 11,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p28',
      productTitle: "Hawaiian Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 160.0,
      rating: 4.2,
      reviewsCount: 50,
      description:
          "Sweet pineapple chunks combined with savory ham and cheese.",
      category: "Meals",
      subtitle: 'Hawaiian',
      stockQuantity: 9,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(   
      id: 'p29',
      productTitle: "Seafood Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 220.0,
      rating: 4.8,
      reviewsCount: 75,
      description: "Topped with shrimp, calamari, garlic, and herbs.",
      category: "Meals",
      subtitle: 'Seafood',
      stockQuantity: 6,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p30',
      productTitle: "Buffalo Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 185.0,
      rating: 4.8,
      reviewsCount: 105,
      description: "Spicy buffalo chicken breast with ranch dressing drizzle.",
      category: "Meals",
      subtitle: 'Buffalo',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p31',
      productTitle: "Mushroom Truffle Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 200.0,
      rating: 4.9,
      reviewsCount: 125,
      description: "Earthy wild mushrooms infused with exquisite truffle oil.",
      category: "Meals",
      subtitle: 'Truffle',
      stockQuantity: 7,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p32',
      productTitle: "Supreme Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 195.0,
      rating: 4.7,
      reviewsCount: 95,
      description: "The ultimate mix of meats, veggies, and extra cheese.",
      category: "Meals",
      subtitle: 'Supreme',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p33',
      productTitle: "Pesto Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 175.0,
      rating: 4.6,
      reviewsCount: 60,
      description: "Green basil pesto base topped with tender grilled chicken.",
      category: "Meals",
      subtitle: 'Pesto',
      stockQuantity: 13,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p34',
      productTitle: "Calzone Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 165.0,
      rating: 4.5,
      reviewsCount: 55,
      description: "Folded pizza pocket stuffed with rich cheese and fillings.",
      category: "Meals",
      subtitle: 'Calzone',
      stockQuantity: 15,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p35',
      productTitle: "Mexican Spicy Pizza",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 180.0,
      rating: 4.8,
      reviewsCount: 110,
      description: "Ground beef, jalapenos, onions, and spicy Mexican spices.",
      category: "Meals",
      subtitle: 'Mexican',
      stockQuantity: 9,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p36',
      productTitle: "White Garlic Pizza",
      productImage:
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500",
      price: 155.0,
      rating: 4.4,
      reviewsCount: 45,
      description: "Creamy garlic white sauce with herbs and mozzarella.",
      category: "Meals",
      subtitle: 'Garlic',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p37',
      productTitle: "Greek Pizza",
      productImage:
          "https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500",
      price: 160.0,
      rating: 4.6,
      reviewsCount: 70,
      description: "Feta cheese, black olives, tomatoes, and fresh spinach.",
      category: "Meals",
      subtitle: 'Greek',
      stockQuantity: 11,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p38',
      productTitle: "Double Pepperoni Pizza",
      productImage:
          "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=500",
      price: 190.0,
      rating: 4.9,
      reviewsCount: 150,
      description: "Double layers of crispy pepperoni for maximum flavor.",
      category: "Meals",
      subtitle: 'Pepperoni',
      stockQuantity: 14,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p39',
      productTitle: "Ranch Chicken Pizza",
      productImage:
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500",
      price: 185.0,
      rating: 4.7,
      reviewsCount: 85,
      description: "Smooth ranch dressing base with tender chicken and bacon.",
      category: "Meals",
      subtitle: 'Ranch',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),
    ProductModel(
      id: 'p40',
      productTitle: "Mini Pizza Combo",
      productImage:
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500",
      price: 140.0,
      rating: 4.5,
      reviewsCount: 40,
      description: "Set of three mini personal pizzas with mixed toppings.",
      category: "Meals",
      subtitle: 'Combo',
      oldPrice: 155.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 16,
      minStockAlert: 5,
      storageLocation: 'Main Storage',
    ),

    // ==================== Supplements ====================
    ProductModel(
      id: 'p41',
      productTitle: "Cold Mojito",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 45.0,
      rating: 4.9,
      reviewsCount: 60,
      description: "Refreshing cold mojito drink with mint and lime.",
      category: "Supplements",
      subtitle: 'Mojito',
      stockQuantity: 30,
      minStockAlert: 10,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p42',
      productTitle: "Fresh Orange Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 35.0,
      rating: 4.7,
      reviewsCount: 50,
      description: "100% fresh squeezed orange juice packed with vitamins.",
      category: "Supplements",
      subtitle: 'Juice',
      oldPrice: 45.0,
      updatedBy: "Admin Ahmed",
      stockQuantity: 20,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p43',
      productTitle: "Iced Caramel Macchiato",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 55.0,
      rating: 4.8,
      reviewsCount: 90,
      description:
          "Cold espresso layered with vanilla milk and caramel drizzle.",
      category: "Supplements",
      subtitle: 'Coffee',
      oldPrice: 65.0,
      updatedBy: "Barworker Omar",
      stockQuantity: 25,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p44',
      productTitle: "Strawberry Smoothie",
      productImage:
          "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500",
      price: 50.0,
      rating: 4.6,
      reviewsCount: 70,
      description: "Thick and creamy blended strawberry fruit smoothie.",
      category: "Supplements",
      subtitle: 'Smoothie',
      oldPrice: 60.0,
      updatedBy: "Barworker Omar",
      stockQuantity: 15,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p45',
      productTitle: "Lemon Mint Cooler",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 40.0,
      rating: 4.7,
      reviewsCount: 55,
      description: "Zesty lemon juice blended with crushed fresh mint leaves.",
      category: "Supplements",
      subtitle: 'Cooler',
      stockQuantity: 22,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p46',
      productTitle: "Chocolate Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 60.0,
      rating: 4.8,
      reviewsCount: 100,
      description: "Rich chocolate thick milkshake topped with whipped cream.",
      category: "Supplements",
      subtitle: 'Shake',
      oldPrice: 70.0,
      updatedBy: "Barworker Omar",
      stockQuantity: 18,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p47',
      productTitle: "Oreo Shake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 65.0,
      rating: 5.0,
      reviewsCount: 140,
      description:
          "Blended cookies and cream milkshake with crunchy Oreo bits.",
      category: "Supplements",
      subtitle: 'Shake',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p48',
      productTitle: "Iced Spanish Latte",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 55.0,
      rating: 4.9,
      reviewsCount: 110,
      description: "Sweet condensed milk mixed with bold iced espresso shots.",
      category: "Supplements",
      subtitle: 'Coffee',
      stockQuantity: 20,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p49',
      productTitle: "Green Detox Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 45.0,
      rating: 4.4,
      reviewsCount: 40,
      description:
          "Healthy green juice with spinach, green apple, and cucumber.",
      category: "Supplements",
      subtitle: 'Detox',
      stockQuantity: 10,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p50',
      productTitle: "Watermelon Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 35.0,
      rating: 4.7,
      reviewsCount: 65,
      description: "Super refreshing ice-cold natural watermelon juice.",
      category: "Supplements",
      subtitle: 'Juice',
      stockQuantity: 25,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p51',
      productTitle: "Passion Fruit Mojito",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 50.0,
      rating: 4.8,
      reviewsCount: 80,
      description: "Exotic passion fruit flavored sparkling mojito drink.",
      category: "Supplements",
      subtitle: 'Mojito',
      stockQuantity: 16,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p52',
      productTitle: "Vanilla Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 55.0,
      rating: 4.5,
      reviewsCount: 50,
      description: "Classic creamy vanilla milkshake with a cherry on top.",
      category: "Supplements",
      subtitle: 'Shake',
      stockQuantity: 14,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p53',
      productTitle: "Iced Americano",
      productImage:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      price: 35.0,
      rating: 4.6,
      reviewsCount: 60,
      description:
          "Pure espresso shots poured over crystal clear ice and water.",
      category: "Supplements",
      subtitle: 'Coffee',
      stockQuantity: 30,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p54',
      productTitle: "Blueberry Smoothie",
      productImage:
          "https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500",
      price: 55.0,
      rating: 4.7,
      reviewsCount: 75,
      description: "Antioxidant-rich wild blueberry blended smoothie.",
      category: "Supplements",
      subtitle: 'Smoothie',
      stockQuantity: 12,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p55',
      productTitle: "Peach Ice Tea",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 40.0,
      rating: 4.6,
      reviewsCount: 55,
      description: "Chilled black tea infused with sweet natural peach flavor.",
      category: "Supplements",
      subtitle: 'Tea',
      stockQuantity: 22,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p56',
      productTitle: "Avocado Honey Milkshake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 65.0,
      rating: 4.9,
      reviewsCount: 95,
      description: "Rich avocado blended with milk and organic wild honey.",
      category: "Supplements",
      subtitle: 'Shake',
      stockQuantity: 8,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p57',
      productTitle: "Pomegranate Juice",
      productImage:
          "https://images.unsplash.com/photo-1613478223719-2ab802602423?w=500",
      price: 50.0,
      rating: 4.8,
      reviewsCount: 70,
      description: "Freshly pressed tart and sweet ruby red pomegranate juice.",
      category: "Supplements",
      subtitle: 'Juice',
      stockQuantity: 15,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p58',
      productTitle: "Caramel Popcorn Shake",
      productImage:
          "https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500",
      price: 70.0,
      rating: 4.9,
      reviewsCount: 120,
      description: "Unique milkshake blended with caramel popcorn and sauce.",
      category: "Supplements",
      subtitle: 'Shake',
      stockQuantity: 9,
      minStockAlert: 5,
      storageLocation: 'Bar Fridge',
    ),
    ProductModel(
      id: 'p59',
      productTitle: "Sparkling Mineral Water",
      productImage:
          "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500",
      price: 20.0,
      rating: 4.3,
      reviewsCount: 30,
      description: "Crisp and refreshing carbonated bottled mineral water.",
      category: "Supplements",
      subtitle: 'Water',
      stockQuantity: 50,
      minStockAlert: 15,
      storageLocation: 'Bar Fridge',
    ),
  ].obs;

  // الفلترة الحالية بناءً على الفئة المختارة
  List<ProductModel> get filteredProducts {
    return products.where((p) => p.category == selectedCategory.value).toList();
  }

  // تغيير الفئة وتحديث الشاشة فوراً
  void changeCategory(String category) {
    selectedCategory.value = category;
    update(); 
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // ==================== الوظائف البرمجية الجديدة للمخزن وإدارة الأسعار ====================

  /// دالة لتحديث كمية المخزن لأي منتج
  void updateStock(String productId, int newQuantity) {
    int index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      var product = products[index];
      products[index] = ProductModel(
        id: product.id,
        productTitle: product.productTitle,
        productImage: product.productImage,
        price: product.price,
        oldPrice: product.oldPrice,
        updatedBy: product.updatedBy,
        subtitle: product.subtitle,
        category: product.category,
        isAvailable: product.isAvailable,
        statusMessage: product.statusMessage,
        description: product.description,
        rating: product.rating,
        reviewsCount: product.reviewsCount,
        stockQuantity: newQuantity, // الكمية المحدثة
        minStockAlert: product.minStockAlert,
        storageLocation: product.storageLocation,
      );
      update();
      Get.snackbar("Success", "Stock quantity updated successfully!");
    }
  }

  /// دالة لتعديل سعر المنتج وتسجيل السعر القديم واسم الأدمن أو الموظف المسؤول
  void updateProductPrice(String productId, double newPrice, String updaterName) {
    int index = products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      var product = products[index];
      products[index] = ProductModel(
        id: product.id,
        productTitle: product.productTitle,
        productImage: product.productImage,
        price: newPrice,
        oldPrice: product.price, // حفظ السعر الحالي كـ سعر قديم تلقائياً
        updatedBy: updaterName,  // اسم المسؤول عن التعديل (مثل Admin Ahmed)
        subtitle: product.subtitle,
        category: product.category,
        isAvailable: product.isAvailable,
        statusMessage: product.statusMessage,
        description: product.description,
        rating: product.rating,
        reviewsCount: product.reviewsCount,
        stockQuantity: product.stockQuantity,
        minStockAlert: product.minStockAlert,
        storageLocation: product.storageLocation,
      );
      update();
      Get.snackbar("Success", "Price updated and logged successfully!");
    }
  }

  /// قائمة المنتجات التي تعاني من نقص في المخزن (Low Stock)
  List<ProductModel> get lowStockProducts {
    return products.where((p) => p.stockQuantity <= p.minStockAlert).toList();
  }
}