part of widgets;

class CloseBottomSheet extends StatelessWidget {
  final BuildContext context;
  const CloseBottomSheet({this.context});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: LineIcon.timesCircle(color: AppColors.textColor),
      style: ElevatedButton.styleFrom(
          shape: CircleBorder(), elevation: 0, primary: AppColors.primaryMediumColor),
    );
  }
}
