class ProductModel {
  final String productTitle; 
  final String productImage; 
  final double price; 
  final double rating; 
  final int reviewsCount; 
  final String description; 
  final String category; // الفئة التابع لها (مثلاً: "Burgers", "Pizza", "Drinks", "Desserts")

  ProductModel({ 
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.category,
  });
}