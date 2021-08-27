import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../main_body.dart';

class SignForm extends StatefulWidget {
  SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtPhone = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  final List<String> errors = [];
  bool _isShowPassword;

  void _loginUser() async {
    String result = await Provider.of<AuthProvider>(context, listen: false)
        .login(phone: _txtPhone.text, password: _txtPassword.text);
    result == null
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainBody()),
            (route) => false)
        : ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$result')));
    setState(() {
      loading = !loading;
    });
  }
  void _redirectToOTP(UserModel user) async {
    // Navigator.of(context).pushNamed(OTPScreen.routeName, arguments: user);
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen()));
  }

  @override
  void initState() {
    super.initState();
    _isShowPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneField(),
          SizedBox(height: 15.0),
          buildPasswordField(),
          SizedBox(height: 15.0),
          loading
              ? Center(child: CircularProgressIndicator())
              : SignButton(
                  text: 'Sign in',
                  onSubmit: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = !loading;
                        _loginUser();
                      });
                      final signcode = await SmsAutoFill().getAppSignature;
                      print(signcode);
                    }
                  }),
        ],
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _txtPassword,
      validator: (value) =>
          value.length < 6 ? 'Required at least 6 chars.' : null,
      style: TextStyle(fontSize: 14.0),
      decoration: InputDecoration(
          prefixIcon: LineIcon.lock(
            size: 26.0,
            color: primaryMediumColor,
          ),
          suffixIcon: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: Text(
                    'Forgot ?',
                    style: TextStyle(
                        color: primaryMediumColor,
                        fontSize: 13.0,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowPassword = !_isShowPassword;
                    });
                  },
                  child: _isShowPassword
                      ? LineIcon.eyeSlash(
                          size: 30.0,
                        )
                      : LineIcon.eye(
                          size: 30.0,
                        ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter your password',
          labelText: 'Password'),
      obscureText: !_isShowPassword,
      textInputAction: TextInputAction.done,
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      controller: _txtPhone,
      validator: (value) => value.isEmpty ? 'Invalid phone number' : null,
      keyboardType: TextInputType.phone,
      style: TextStyle(fontSize: 14.0),
      decoration: InputDecoration(
          prefixIcon: LineIcon.phone(
            size: 26.0,
            color: primaryMediumColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter your phone number',
          labelText: 'Phone number'),
      textInputAction: TextInputAction.next,
    );
  }
}
