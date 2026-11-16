//import 'package:myfirstapp/gym/customer_view/gym_bar/model/cart_model.dart';
import 'package:myfirstapp/gym_app/customer_view/gym_bar/model/items_model.dart';


class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}