part of screens;

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
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    return Stack(
      children: <Widget>[
        Image.asset(
          Res.more_background,
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
          child: Consumer<AuthProvider>(builder: (context, provider, child) {
            final UserModel user = provider.getUser;
            return Column(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: user.image == null
                            ? AssetImage(Res.img_default_user)
                            : base64StringToImage(user.image),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${user.displayName}',
                  style: TextStyle(
                      color: AppColors.textColor,
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
                    border: Border.all(color: AppColors.textColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(userProvider.getLevelString(),
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.eco_outlined,
                        color: AppColors.textColor,
                        size: 22.0,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: LanguagePicker(),
        )
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
