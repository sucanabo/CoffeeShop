
import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/providers/navigation_provider.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/validate.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/pop_up_notify.dart';
import 'package:coffee_shop/widgets/rounded_dropdown.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({@required this.imgPath});
  final String imgPath;
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _txtDisplayName = TextEditingController();
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
    _txtDisplayName.text = user.displayName;
    _txtBithday.text = formatDateToString(user.birthday);
    _dropdownGender = user.gender;
    _isEmailVerified = user.isEmailVerified;
  }

  submitForm() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final naviProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    String newImg = widget.imgPath ?? provider.getUser.image;
    String newDisplayName =
        _txtDisplayName.text.trim() != provider.getUser.displayName
            ? _txtDisplayName.text.trim()
            : provider.getUser.displayName;
    String newEmail = _txtEmail.text.trim() != provider.getUser.email
        ? _txtEmail.text.trim()
        : provider.getUser.email;
    String newGender = _dropdownGender != provider.getUser.gender
        ? _dropdownGender
        : provider.getUser.gender;
    if (_formKey.currentState.validate()) {
      naviProvider.setLoading(true);
      await provider.updateUser(UserModel(
          image: newImg ?? '',
          displayName: newDisplayName,
          email: newEmail,
          gender: newGender));
      naviProvider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listGender = ['male', 'female', 'other'];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedTextField(
              validator: (value) => Validate.displayNameValidate(value),
              controller: _txtDisplayName,
              label: 'Display name',
              hintText: 'Display name'),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            controller: _txtPhone,
            label: 'Phone',
            enabled: false,
            readOnly: true,
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            validator: (value) => Validate.emailValidate(value),
            controller: _txtEmail,
            label: 'Email',
            suffix: _isEmailVerified
                ? Icon(
                    Icons.check,
                    color: Colors.green[400],
                  )
                : IconButton(
                    onPressed: _verifyDialog,
                    icon: LineIcon.exclamationCircle(
                      color: Colors.orange[500],
                    ),
                  ),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            controller: _txtBithday,
            label: 'Birthday',
            isDate: true,
            readOnly: true,
            enabled: false,
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedDropDown(
            label: 'Gender',
            value: _dropdownGender,
            listItem: listGender,
            validator: null,
            onChanged: (value) {
              setState(() {
                _dropdownGender = value;
              });
            },
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.035),
          PillButton(
              child: Text(
                'Update Profile',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {
                submitForm();
              },
              color: AppColors.primaryColor),
        ],
      ),
    );
  }

  _verifyDialog() {
    return showDialog(
        context: context,
        builder: (context) => new PopUpNotify(
              title: 'Your email is not verified',
              content: Text(
                'Verify email to get more important informations and use to reset your password.',
                textAlign: TextAlign.center,
              ),
              actions: [
                PillButton(
                  child: Text('Verify now'),
                  onPressed: () {
                    print('aa');
                  },
                )
              ],
            ));
  }
}
