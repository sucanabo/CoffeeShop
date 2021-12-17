part of screens;
class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    final String phone = ModalRoute.of(context).settings.arguments as String;
    print(phone);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.forgot_password.tr(),
          ),
        ),
        body: ForgotPasswordBody(
          phone: phone,
        ));
  }
}
