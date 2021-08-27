import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Carousel(
      dotBgColor: Colors.transparent,
      indicatorBgPadding: 5.0,
      dotIncreasedColor: primaryMediumColor,
      dotColor: Colors.grey[400],
      dotPosition: DotPosition.bottomRight,
      images: [
        Image.asset('assets/images/banner/16280TheCoffeeHouse_1534905202.png',
            fit: BoxFit.fill),
        Image.asset(
          'assets/images/banner/20200316_AppVinID_BannerWeb_TCH_25.jpg',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'assets/images/banner/20200316_AppVinID_BannerWeb_TCH_30k.jpg',
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
