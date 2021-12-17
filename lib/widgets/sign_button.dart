part of widgets;

class SignButton extends StatelessWidget {
  final String text;
  final Function onSubmit;
  const SignButton({@required this.text, @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: AppColors.textColor, fontSize: 30.0, fontWeight: FontWeight.w600),
        ),
        ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
                elevation: 5.0,
                primary: AppColors.primaryColor,
                shadowColor: AppColors.primaryColor,
                shape: CircleBorder(),
                padding: EdgeInsets.all(0.0)),
            child: Icon(
              Icons.chevron_right_rounded,
              size: 40.0,
            ))
      ],
    );
  }
}
