part of screens;

class SignInBody extends StatefulWidget {
  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.hint_let_sign_in.tr(),
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: getWidth(28.0),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              child: Text(
                LocaleKeys.welcome_back.tr(),
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SignForm(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.dont_have_account.tr()),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              style: TextButton.styleFrom(
                  alignment: Alignment.topCenter, padding: EdgeInsets.zero),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(LocaleKeys.sign_up.tr(),
                    style: TextStyle(color: AppColors.primaryMediumColor)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.primaryMediumColor,
                )
              ]),
            ),
          ],
        ),
        SignInWith()
      ],
    ));
  }
}
