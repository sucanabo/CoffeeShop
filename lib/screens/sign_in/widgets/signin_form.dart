import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/validate.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../main_body.dart';

class SignForm extends StatefulWidget {
  SignForm({Key key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtPhone = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  final List<String> errors = [];
  void _loginUser() async {
    final naviProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    naviProvider.setLoading(true);
    String result = await Provider.of<AuthProvider>(context, listen: false)
        .login(phone: _txtPhone.text, password: _txtPassword.text);
    result == null
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainBody()),
            (route) => false)
        : ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$result')));

    naviProvider.setLoading(false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _txtPhone.dispose();
    _txtPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedTextField(
            controller: _txtPhone,
            hintText: 'Enter your phone number',
            label: 'Phone number',
            prefixIcon: Res.ic_phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => Validate.phoneValidate(value),
          ),
          SizedBox(height: 24.0),
          RoundedTextField(
            label: 'Password',
            hintText: 'Enter password',
            isPassword: true,
            controller: _txtPassword,
            prefixIcon: Res.ic_lock,
            textInputAction: TextInputAction.done,
            validator: (value) => Validate.passwordValidate(value),
          ),
          SizedBox(height: 20.0),
          SignButton(
              text: 'Sign in',
              onSubmit: () async {
                if (_formKey.currentState.validate()) {
                  hideKeyboard(context);
                  _loginUser();
                }
              }),
        ],
      ),
    );
  }
}
