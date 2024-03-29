import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shop_app/consts/firebase_const.dart';
import 'package:grocery_shop_app/providers/products_provider.dart';
import 'package:grocery_shop_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';
import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProdduct = productsProvider.findProById(productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        try {
          final User? user = authInstance.currentUser;
          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first!',
                context: context);
            return;
          }
          if (isInWishlist == false) {
            GlobalMethods.addToWishlist(productId: productId, context: context);
          } else {
            wishlistProvider.removeOneItem(
                wishlistId: wishlistProvider
                    .getWishlistItems[getCurrentProdduct.id]!.id,
                productId: productId);
          }
          await wishlistProvider.fetchWishlist();
        } catch (error) {
          GlobalMethods.errorDialog(subtitle: error.toString(), context: context);
        } finally {}
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color:
            isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
