part of widgets;

class Loading extends StatelessWidget {
  const Loading({this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primaryColor));
  }
}
