class ProductModel {
  final String productTitle;  
  final String productImage;   
  final double price;          
  final double? oldPrice;      // السعر القديم (اختياري)
  final String? updatedBy;     // اسم الشخص أو الأدمن اللي عدل السعر (اختياري)
  final String subtitle;      
  final String category;      
  final bool isAvailable;     
  final String? statusMessage; 
  final String description;
  final double rating;
  final int reviewsCount;

  ProductModel({
    required this.productTitle,
    required this.productImage,
    required this.price,
    this.oldPrice,             // مش required عشان ميضربش إيرور في باقي التطبيق
    this.updatedBy,            // مش required
    required this.subtitle,
    required this.category,
    this.isAvailable = true,
    this.statusMessage,
    this.description = "",
    this.rating = 0.0,
    this.reviewsCount = 0,
  });
}