part of widgets;

class ScreenBodyLoading extends StatelessWidget {
  final Color indicatorColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  const ScreenBodyLoading({this.indicatorColor, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return ScreenBody(
      margin: margin,
      padding: padding,
      child: Center(
        child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(indicatorColor ?? AppColors.primaryColor),
        ),
      ),
    );
  }
}
