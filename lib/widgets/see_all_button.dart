part of widgets;

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({@required this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      onPressed: onPressed,
      child: Text(
        LocaleKeys.see_all.tr(),
        style: TextStyle(color: AppColors.primaryColor),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 10.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: AppColors.primaryColor),
            ),
          )),
    ));
  }
}

class LocalKeys {}
