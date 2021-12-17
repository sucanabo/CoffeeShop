part of screens;

class BottomBar extends StatelessWidget {
  final double price;
  final Function buttonPress;
  final String buttonText;

  BottomBar(
      {@required this.price,
      @required this.buttonPress,
      @required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: SizeConfig.screenHeigh * 0.085,
          decoration: BoxDecoration(
              color: AppColors.darkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.total.tr(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        convertVND(price),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 20.0,
                      )
                    ]),
              ),
              Expanded(
                flex: 5,
                child: RoundedButton(
                  onPressed: buttonPress,
                  title: buttonText,
                  fontSize: 16.0,
                  color: AppColors.primaryLightColor,
                  textColor: AppColors.darkColor,
                ),
              )
            ],
          ),
        ));
  }
}
