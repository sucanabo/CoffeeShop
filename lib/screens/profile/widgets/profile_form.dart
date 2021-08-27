import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:coffee_shop/values/function.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtFirstName = TextEditingController();
  final TextEditingController _txtLastName = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPhone = TextEditingController();
  final TextEditingController _txtBithday = TextEditingController();
  bool _isEmailVerified;
  String _dropdownGender;
  DateTime birthday;
  @override
  // ignore: must_call_super
  void initState() {
    final user = Provider.of<AuthProvider>(context, listen: false).getUser;
    _txtPhone.text = user.phone;
    _txtEmail.text = user.email;
    _txtFirstName.text = user.firstName;
    _txtLastName.text = user.lastName;
    _txtBithday.text = formartDate(user.birthday);
    _dropdownGender = user.gender;
    _isEmailVerified = user.isEmailVerified;
  }

  @override
  Widget build(BuildContext context) {
    List<String> listGender = ['male', 'female', 'other'];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _txtFirstName,
                    decoration: InputDecoration(
                        labelText: 'First name', hintText: 'abc'),
                  )),
              SizedBox(width: 10.0),
              Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: _txtLastName,
                    decoration: InputDecoration(
                        labelText: 'Last name', hintText: 'abc'),
                  )),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          TextFormField(
            controller: _txtPhone,
            decoration: InputDecoration(
                enabled: false, labelText: 'Phone', hintText: 'abc'),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          TextFormField(
            controller: _txtEmail,
            decoration: InputDecoration(
                labelText: 'Email',
                suffixIcon: _isEmailVerified
                    ? Icon(
                        Icons.check,
                        color: Colors.green[400],
                      )
                    : LineIcon.exclamationCircle(
                        color: Colors.orange[500],
                      ),
                hintText: 'email'),
          ),
          if (!_isEmailVerified) _buildEmailVerify(),
          TextFormField(
            controller: _txtBithday,
            decoration: InputDecoration(
                suffixIcon: LineIcon.calendar(),
                enabled: false,
                labelText: 'Birthday',
                hintText: 'abc'),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          Container(
            padding:
                EdgeInsets.only(left: 20.0, right: 15.0, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all()),
            child: DropdownButton(
                value: _dropdownGender,
                dropdownColor: Colors.white,
                focusColor: primaryColor,
                icon: LineIcon.chevronCircleDown(),
                hint: Text('Select gender'),
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(color: textColor),
                onChanged: (value) {
                  setState(() {
                    _dropdownGender = value;
                  });
                },
                items: listGender
                    .map((gender) => DropdownMenuItem(
                        value: gender, child: Text(gender.capitalize())))
                    .toList()),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.035),
          PillButton(
              child: Text(
                'Update Profile',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {},
              color: primaryColor),
        ],
      ),
    );
  }

  _buildDialog() {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: Text('Koffeeholic has been sent to your mail'),
              content: Container(
                child: Text('Please check your mail into 48 hours.'),
              ),
              actions: [
                RoundedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'OK',
                  color: primaryMediumColor,
                )
              ],
            ));
  }

  Container _buildEmailVerify() => Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Column(
        children: [
          Text(
              'You will receive more important information and use email for set password or phone number.'),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: darkColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              onPressed: () => _buildDialog(),
              child: Text('Verify Email'))
        ],
      ));
}
