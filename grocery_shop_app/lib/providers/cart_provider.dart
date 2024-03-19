import 'package:flutter/cupertino.dart';
import 'package:grocery_shop_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductsToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
              id: DateTime.now().toString(),
              productId: productId,
              quantity: quantity,
            ));
  }
}
