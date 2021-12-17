part of screens;

class NewPasswordScreen extends StatefulWidget {
  static String routeName = '/new_password';
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtReEnterPassword = TextEditingController();
  void submitForm(UserModel user) async {
    if (_formKey.currentState.validate()) {
      setLoading(context, loading: true);
      bool result = await Provider.of<AuthProvider>(context, listen: false)
          .signup(user: user, password: _txtPassword.text.trim());
      if (result) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => MainBody()),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignInScreen()),
            (route) => false);
      }

      setLoading(context, loading: false);
    }
  }

  @override
  void dispose() {
    _txtPassword.dispose();
    _txtReEnterPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _user = ModalRoute.of(context).settings.arguments;
    return ScreenBody(
      appBar: AppBar(
        title: Text(LocaleKeys.new_password.tr()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Text(
                LocaleKeys.last_step.tr(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: getWidth(28.0),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                LocaleKeys.hint_pwd_essential.tr(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      RoundedTextField(
                        label: LocaleKeys.password.tr(),
                        hintText: LocaleKeys.enter_password.tr(),
                        controller: _txtPassword,
                        isPassword: true,
                        validator: (value) => Validate.passwordValidate(value),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundedTextField(
                        label: LocaleKeys.password_confirm.tr(),
                        hintText: LocaleKeys.re_enter_password.tr(),
                        controller: _txtReEnterPassword,
                        isPassword: true,
                        validator: (value) => Validate.reEnterPasswordValidate(
                            value, _txtPassword.text),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 3,
            child: Align(
              child: Container(
                width: SizeConfig.screenWidth,
                child: RoundedButton(
                  onPressed: () => submitForm(_user),
                  color: AppColors.primaryColor,
                  title: LocaleKeys.sign_up.tr(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
