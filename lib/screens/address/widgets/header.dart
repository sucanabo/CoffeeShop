import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final double expandHeight;
  final double roundedContainerHeight;
  Header({@required this.expandHeight, @required this.roundedContainerHeight});
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: MoreScreenSliverDelegate(
          expandHeight: expandHeight,
          roundedContainerHeight: roundedContainerHeight),
    );
  }
}

class MoreScreenSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandHeight;
  final double roundedContainerHeight;
  MoreScreenSliverDelegate({this.expandHeight, this.roundedContainerHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final UserModel user = Provider.of<AuthProvider>(context).getUser;
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/more_background.jpg',
          fit: BoxFit.cover,
          width: SizeConfig.screenWidth,
        ),
        Positioned(
          top: expandHeight - roundedContainerHeight - shrinkOffset,
          left: 0,
          child: Container(
            width: SizeConfig.screenWidth,
            height: roundedContainerHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
          ),
        ),
        Positioned(
          top: 15 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: Column(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: user.image == 'default_user.png'
                          ? AssetImage('assets/images/${user.image}')
                          : base64StringToImage(user.image),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(
                    color: textColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: textColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                    Icon(
                      Icons.eco_outlined,
                      color: textColor,
                      size: 22.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}