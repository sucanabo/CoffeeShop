import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main_body.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}
class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPhone = TextEditingController();
    TextEditingController txtFirstName = TextEditingController();
    TextEditingController txtlastName = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    TextEditingController txtPasswordConfirmation = TextEditingController();

    void _saveAndRedirectToHome(UserModel user) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('token', user.token ?? '');
      pref.setInt('id', user.id ?? 0);

      //Navigate to Home
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainBody()),
          (route) => false);
    }

    void _registerUser() async {
      ApiResponse response = await register(
          email: txtEmail.text,
          phone: txtPhone.text,
          firstName: txtFirstName.text,
          lastName: txtlastName.text,
          password: txtPassword.text);
      if (response.error == null) {
        _saveAndRedirectToHome(response.data as UserModel);
      } else {
        setState(() {
          loading = !loading;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'First name is requried' : null,
                        controller: txtFirstName,
                        style: TextStyle(fontSize: 14.0),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: 'First name',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    )),
                Expanded(
                    flex: 7,
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Last name is requried' : null,
                      controller: txtlastName,
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                        hintText: 'Last name',
                      ),
                      textInputAction: TextInputAction.next,
                    ))
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value) => value.isEmpty ? 'Email is requried' : null,
              controller: txtEmail,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                hintText: 'Email',
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              //validator: (value) => value.isEmpty ? 'Phone is requried' : null,
              //controller: txtPhone,
              //keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(hintText: 'Phone number'),
              //textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: txtPassword,
              validator: (value) =>
                  value.length < 6 ? 'Required at least 6 chars.' : null,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  width: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: LineIcon.eye(),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                hintText: 'Password',
              ),
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value) => value != txtPassword.text
                  ? 'Confirm password does not match'
                  : null,
              controller: txtPasswordConfirmation,
              style: TextStyle(fontSize: 14.0),
              decoration: InputDecoration(
                suffixIcon: SizedBox(
                  width: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: LineIcon.eye(),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                hintText: 'Confirm Password',
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: SizeConfig.screenHeigh * 0.025),
            loading
                ? Center(child: CircularProgressIndicator())
                : SignButton(
                    text: 'Sign up',
                    onSubmit: () {
                      setState(() {
                        loading = !loading;
                        _registerUser();
                      });
                    })
          ],
        ));
  }
}
