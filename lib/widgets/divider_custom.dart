part of widgets;

class DividerCustom extends StatelessWidget {
  const DividerCustom({this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height != null ? height * 2 : getHeight(20),
      color: AppColors.blackColor.withOpacity(0.12),
      thickness: 1,
    );
  }
}
