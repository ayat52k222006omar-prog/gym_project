import 'package:get/get.dart';
import '../model/product_model.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  var items = <CartItemModel>[].obs;

  void addProduct(ProductModel product, {int quantity = 1}) {
    final index = items.indexWhere((item) => item.product.productTitle == product.productTitle);
    if (index >= 0) {
      items[index].quantity += quantity;
      items.refresh();
    } else {
      items.add(CartItemModel(product: product, quantity: quantity));
    }
  }

  void increaseQuantity(int index) {
    items[index].quantity++;
    items.refresh();
  }

  void decreaseQuantity(int index) {
    if (items[index].quantity > 1) {
      items[index].quantity--;
      items.refresh();
    } else {
      items.removeAt(index);
    }
  }

  void removeProduct(CartItemModel cartItem) {
    items.remove(cartItem);
  }

  void clearCart() {
    items.clear();
  }

  double get subtotal {
    double totalSum = 0.0;
    for (var item in items) {
      totalSum += item.total;
    }
    return totalSum;
  }

  double get deliveryFee {
    return items.isEmpty ? 0.0 : 30.0;
  }

  double get total {
    return items.isEmpty ? 0.0 : subtotal + deliveryFee;
  }
}