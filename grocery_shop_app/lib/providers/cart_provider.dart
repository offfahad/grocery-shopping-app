import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_shop_app/consts/firebase_const.dart';
import 'package:grocery_shop_app/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  // void addProductsToCart({
  //   required String productId,
  //   required int quantity,
  // }) {
  //   _cartItems.putIfAbsent(
  //     productId,
  //     () => CartModel(
  //       id: DateTime.now().toString(),
  //       productId: productId,
  //       quantity: quantity,
  //     ),
  //   );
  //   notifyListeners();
  // }

  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    String _uid = user!.uid;
    final DocumentSnapshot userDocs =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (user == null) {
      return;
    }
    final length = userDocs.get('userCart').length;
    for (int i = 0; i < length; i++) {
      _cartItems.putIfAbsent(
        userDocs.get('userCart')(i)['productId'],
        () => CartModel(
          id: userDocs.get('userCart')(i)['cartId'],
          productId: userDocs.get('userCart')(i)['productId'],
          quantity: userDocs.get('userCart')(i)['quantity'],
        ),
      );
    }
    notifyListeners();
  }

  void reduceQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );

    notifyListeners();
  }

  void increaseQuantityByOne(String productId) {
    _cartItems.update(
      productId,
      (value) => CartModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeOneItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
