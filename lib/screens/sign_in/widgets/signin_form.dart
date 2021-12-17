part of screens;

class SignForm extends StatefulWidget {
  SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtPhone = TextEditingController();
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _txtPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getHeight(100.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedTextField(
              controller: _txtPhone,
              hintText: LocaleKeys.enter_phone_number.tr(),
              label: LocaleKeys.phone.tr(),
              prefixIcon: Res.ic_phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: (value) => Validate.phoneValidate(value),
            ),
            SizedBox(height: SizeConfig.screenHeigh * 0.05),
            SignButton(
                text: LocaleKeys.continue_text.tr(),
                onSubmit: () async {
                  if (_formKey.currentState.validate()) {
                    hideKeyboard(context);
                    Navigator.of(context).pushNamed(EnterPassword.routeName,
                        arguments: _txtPhone.text);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
