import 'package:flutter/material.dart';
import 'package:grocery_shop_app/screens/orders/orders_widget.dart';
import 'package:grocery_shop_app/services/utils.dart';
import 'package:grocery_shop_app/widgets/back_widget.dart';
import 'package:grocery_shop_app/widgets/text_widget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: 'Your Order (2)',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            child: OrderWidget(),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: color,
            thickness: 1,
          );
        },
      ),
    );
  }
}
