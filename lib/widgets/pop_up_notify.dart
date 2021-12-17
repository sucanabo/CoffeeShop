part of widgets;

class PopUpNotify extends StatelessWidget {
  const PopUpNotify({this.title, this.content, this.actions});
  final String title;
  final Widget content;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.none,
      backgroundColor: AppColors.transparentColor,
      child: Container(
          width: getWidth(382),
          padding: EdgeInsets.only(
              top: getHeight(15),
              left: getWidth(17),
              right: getWidth(17),
              bottom: getHeight(32)),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(getHeight(30))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? LocaleKeys.notification.tr(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              DividerCustom(
                height: getHeight(16),
              ),
              content ??
                  Text(
                    LocaleKeys.notification.tr(),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
              SizedBox(height: getHeight(29)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                        actions.length,
                        (index) => Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                    left: index != 0 ? 5 : 0,
                                    right: index != actions.length ? 5 : 0,
                                  ),
                                  child: actions[index]),
                            )) ??
                    [
                      PillButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(LocaleKeys.close.tr()),
                      )
                    ],
              ),
            ],
          )),
    );
  }
}
