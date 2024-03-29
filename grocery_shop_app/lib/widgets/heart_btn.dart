import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shop_app/consts/firebase_const.dart';
import 'package:grocery_shop_app/providers/products_provider.dart';
import 'package:grocery_shop_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';
import '../services/utils.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProdduct = productsProvider.findProById(widget.productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        try {
          final User? user = authInstance.currentUser;
          if (user == null) {
            GlobalMethods.errorDialog(
                subtitle: 'No user found, Please login first!',
                context: context);
            return;
          }
          if (widget.isInWishlist == false) {
            GlobalMethods.addToWishlist(
                productId: widget.productId, context: context);
          } else {
            wishlistProvider.removeOneItem(
                wishlistId: wishlistProvider
                    .getWishlistItems[getCurrentProdduct.id]!.id,
                productId: widget.productId);
          }
          await wishlistProvider.fetchWishlist();
          setState(() {
            isLoading = false;
          });
        } catch (error) {
          GlobalMethods.errorDialog(
              subtitle: error.toString(), context: context);
          setState(() {
            isLoading = false;
          });
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: isLoading
          ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
                height: 10, width: 10, child: CircularProgressIndicator()),
          )
          : Icon(
              widget.isInWishlist != null && widget.isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 22,
              color: widget.isInWishlist != null && widget.isInWishlist == true
                  ? Colors.red
                  : color,
            ),
    );
  }
}
