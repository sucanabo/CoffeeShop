part of screens;
class SignUpBody extends StatefulWidget {
  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScreenBody(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  LocaleKeys.great_to_see_you_here.tr(),
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: getWidth(28.0),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  LocaleKeys.sign_up_couple_step.tr(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(child: Center(child: SignUpForm())),
          ],
        ));
  }
}
