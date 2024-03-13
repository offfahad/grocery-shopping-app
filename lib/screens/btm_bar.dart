import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shop_app/screens/cart.dart';
import 'package:grocery_shop_app/screens/categories.dart';
import 'package:grocery_shop_app/screens/home_screen.dart';
import 'package:grocery_shop_app/screens/user.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List _pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[0],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pages[_selectedIndex],
          onTap: _selectedPage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.category),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.buy),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.user2),
              label: "User",
            ),
          ]),
    );
  }
}
