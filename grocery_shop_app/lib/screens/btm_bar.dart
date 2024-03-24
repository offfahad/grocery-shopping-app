import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_shop_app/providers/cart_provider.dart';
import 'package:grocery_shop_app/screens/cart/cart_screen.dart';
import 'package:grocery_shop_app/screens/categories.dart';
import 'package:grocery_shop_app/screens/home_screen.dart';
import 'package:grocery_shop_app/screens/user.dart';
import 'package:grocery_shop_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../provider/dark_theme_provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': CategoriesScreen(), 'title': 'Categories Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
    {'page': const UserScreen(), 'title': 'User Screen'},
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text( _pages[_selectedIndex]['title']),
      // ), 
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white24 : Colors.black45,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>( 
              builder: (_,myCart,ch) {
                return badges.Badge(
                    //toAnimate: true,
                    //shape: BadgeShape.circle,
                    //badgeColor: Colors.blue,
                    //borderRadius: BorderRadius.circular(8),
                    badgeAnimation: const badges.BadgeAnimation.slide(
                      toAnimate: true,
                      animationDuration: Duration(seconds: 1),
                    ),
                    showBadge: true,
                    position: badges.BadgePosition.topEnd(top: -7, end: -7),
                    badgeContent: FittedBox(child: TextWidget(text: myCart.getCartItems.length.toString(), color: Colors.white, textSize: 15)),
                    child: Icon(
                        _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy));
              }
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}
