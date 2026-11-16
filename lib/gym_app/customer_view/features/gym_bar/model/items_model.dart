enum ProductStockStatus { inStock, lowStock, outOfStock }

class ProductModel {
  final String id;
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

  // ==================== بيانات المخزن (Inventory & Stock) ====================
  final int stockQuantity;        // الكمية المتاحة حالياً في المخزن
  final int minStockAlert;        // الحد الأدنى للتنبيه لو الكمية قربت تخلص (مثلاً 5 قطع)
  final String? storageLocation;  // مكان التخزين (مثلاً: Main Storage, Bar Fridge, Reception Shelf)

  ProductModel({
    required this.id,
    required this.productTitle,
    required this.productImage,
    required this.price,
    this.oldPrice,              // مش required عشان ميضربش إيرور في باقي التطبيق
    this.updatedBy,             // مش required
    required this.subtitle,
    required this.category,
    this.isAvailable = true,
    this.statusMessage,
    this.description = "",
    this.rating = 0.0,
    this.reviewsCount = 0,
    // المخزن
    this.stockQuantity = 0,
    this.minStockAlert = 5,
    this.storageLocation,
  });

  // ==================== دوال مساعدة للمخزن (Getters) ====================

  /// حالة المخزن برمجياً (متوفر، قارب على الانفاذ، أو نفاذ المخزون)
  ProductStockStatus get stockStatus {
    if (stockQuantity <= 0) {
      return ProductStockStatus.outOfStock;
    } else if (stockQuantity <= minStockAlert) {
      return ProductStockStatus.lowStock;
    } else {
      return ProductStockStatus.inStock;
    }
  }

  /// نص حالة المخزن جاهز للعرض في الـ Badge (مثل: In Stock, Low Stock, Out of Stock)
  String get stockStatusLabel {
    switch (stockStatus) {
      case ProductStockStatus.inStock:
        return 'In Stock ($stockQuantity)';
      case ProductStockStatus.lowStock:
        return 'Low Stock ($stockQuantity left)';
      case ProductStockStatus.outOfStock:
        return 'Out of Stock';
    }
  }

  /// هل المنتج متاح للبيع في المخزن حالياً؟
  bool get isReadyForSale => isAvailable && stockQuantity > 0;
}