import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop_app/provider/dark_theme_provider.dart';
import 'package:grocery_shop_app/services/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offres/Offer1.jpg',
    'assets/images/offres/Offer2.jpg',
    'assets/images/offres/Offer3.jpg',
    'assets/images/offres/Offer4.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = utils.getScreenSize;
    return Scaffold(
      body: SizedBox(
        height: size.height * 0.33,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              _offerImages[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: _offerImages.length,
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.red)),
          //control: const SwiperControl(color: Colors.black),
        ),
      ),
    );
  }
}
