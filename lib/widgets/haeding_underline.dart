part of widgets;

class HeadingUnderline extends StatelessWidget {
  final String text;
  const HeadingUnderline({this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                color: AppColors.textColor)),
        SizedBox(
            height: 3.0, width: 100.0, child: Container(color: AppColors.primaryColor))
      ],
    );
  }
}
