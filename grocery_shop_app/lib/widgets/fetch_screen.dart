import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_shop_app/providers/products_provider.dart';
import 'package:grocery_shop_app/screens/btm_bar.dart';
import 'package:provider/provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      await productsProvider.fetchProducts();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/imgaes/landing/buyfood.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        Container(color: Colors.black.withOpacity(0.7),),
        const Center(
          child: SpinKitFadingFour(
            color: Colors.white,
          ),
        )
      ]),
    );
  }
}
