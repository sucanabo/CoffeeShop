part of widgets;

Widget openBottomSheet(
    {@required context,
    @required Widget child,
    rewardPoint,
    Function onPressed}) {
  return DraggableScrollableSheet(
    initialChildSize: 0.956,
    maxChildSize: 0.956,
    minChildSize: 0.85,
    builder: (_, controller) => ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: Container(
            height: SizeConfig.screenHeigh,
            child: SingleChildScrollView(
              controller: controller,
              child: child,
            ),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: CloseBottomSheet(context: context)),
        if (rewardPoint != null) _buildRewardBottom(rewardPoint, onPressed)
      ]),
    ),
  );
}

Align _buildRewardBottom(rewardPoint, Function onPressed) {
  return Align(
      alignment: Alignment.bottomCenter - Alignment(0, 0.05),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.0)),
        width: SizeConfig.screenWidth * 0.9,
        height: SizeConfig.screenHeigh * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.use_point.tr(args: [rewardPoint.toString()]),
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Text(
                  LocaleKeys.to_get_reward.tr(),
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: SizeConfig.screenWidth * 0.3,
              child: PillButton(
                onPressed: onPressed,
                child: Text(
                  LocaleKeys.redeem.tr(),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                elevation: 0,
                color: Colors.white,
              ),
            )
          ],
        ),
      ));
}
