part of screens;

class EnterPassword extends StatelessWidget {
  static const String routeName = '/enterPassword';
  const EnterPassword({Key key}) : super(key: key);

  void _loginUser(BuildContext context, phone, String password) async {
    final naviProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    naviProvider.setLoading(true);
    String result = await Provider.of<AuthProvider>(context, listen: false)
        .login(phone: phone, password: password);
    result == null
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainBody()),
            (route) => false)
        : ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$result')));

    naviProvider.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final String phone = ModalRoute.of(context).settings.arguments as String;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _txtPassword = TextEditingController();

    return ScreenBody(
      appBar: AppBar(
        title: Text(LocaleKeys.enter_password.tr()),
      ),
      child: ListView(
        children: [
          Text(
            LocaleKeys.hint_enter_pwd_login.tr(),
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: getWidth(20.0),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeigh * 0.025,
          ),
          Text(
            LocaleKeys.register_phone.tr(args: [phone]),
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: getHeight(100.0),
          ),
          Form(
            key: _formKey,
            child: RoundedTextField(
              label: LocaleKeys.password.tr(),
              hintText: LocaleKeys.enter_password.tr(),
              isPassword: true,
              controller: _txtPassword,
              prefixIcon: Res.ic_lock,
              textInputAction: TextInputAction.done,
              validator: (value) => Validate.passwordValidate(value),
            ),
          ),
          SizedBox(height: getHeight(15)),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName,
                    arguments: phone);
              },
              child: Text(
                '${LocaleKeys.forgot_password.tr()}?',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          SizedBox(height: getHeight(100.0)),
          SignButton(
              text: LocaleKeys.sign_in.tr(),
              onSubmit: () async {
                if (_formKey.currentState.validate()) {
                  _loginUser(context, phone, _txtPassword.text);
                }
              }),
        ],
      ),
    );
  }
}
