import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/screens/main_body.dart';
import 'package:coffee_shop/screens/password/forgot_password/forgot_password_screen.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/validate.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: Text('Enter password'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Enter your password to login app',
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
            'Your registed phone number: $phone',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeigh * 0.07,
          ),
          Form(
            key: _formKey,
            child: RoundedTextField(
              label: 'Password',
              hintText: 'Enter password',
              isPassword: true,
              controller: _txtPassword,
              prefixIcon: Res.ic_lock,
              textInputAction: TextInputAction.done,
              validator: (value) => Validate.passwordValidate(value),
            ),
          ),
          SizedBox(height: 15.0),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
