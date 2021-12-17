import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/rounded_dropdown.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    List<String> listGender = [
      'male',
      'female',
      'other',
    ];
    List<String> listGenderData = [
      LocaleKeys.gender_male.tr(),
      LocaleKeys.gender_female.tr(),
      LocaleKeys.gender_other.tr(),
    ];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedTextField(
              validator: (value) => Validate.displayNameValidate(value),
              controller: _txtDisplayName,
              label: LocaleKeys.display_name.tr(),
              hintText: LocaleKeys.display_name.tr()),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            controller: _txtPhone,
            label: LocaleKeys.phone.tr(),
            enabled: false,
            readOnly: true,
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            validator: (value) => Validate.emailValidate(value),
            controller: _txtEmail,
            label: LocaleKeys.email.tr(),
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedTextField(
            controller: _txtBithday,
            label: LocaleKeys.birthday.tr(),
            isDate: true,
            readOnly: true,
            enabled: false,
          ),
          SizedBox(height: SizeConfig.screenHeigh * 0.025),
          RoundedDropDown(
            label: LocaleKeys.gender_text.tr(),
            value: _dropdownGender,
            listItem: listGender,
            listItemDisplay: listGenderData,
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
                LocaleKeys.update_profile.tr(),
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
}
