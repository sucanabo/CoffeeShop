import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:coffee_shop/widgets/divider_custom.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class ChangePassword extends StatelessWidget {
  const ChangePassword({Key key}) : super(key: key);
  static const String routeName = '/routeName';
  @override
  Widget build(BuildContext context) {
    TextEditingController _txtOldPass = TextEditingController();
    TextEditingController _txtNewPass = TextEditingController();
    TextEditingController _txtConfirm = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void onChangePassword() {
      if (_formKey.currentState.validate()) {
        Provider.of<AuthProvider>(context, listen: false).changePassword(
            context,
            oldPwd: _txtOldPass.text,
            newPwd: _txtNewPass.text);
      }
    }

    return ScreenBody(
      appBar: AppBar(title: Text(LocaleKeys.change_password.tr())),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30.0,
            ),
            RoundedTextField(
              validator: (val) => Validate.passwordValidate(val),
              controller: _txtOldPass,
              isPassword: true,
              hintText: LocaleKeys.password_confirm.tr(),
              label: LocaleKeys.current_password.tr(),
            ),
            // SizedBox(height: 40.0),
            DividerCustom(
              height: 30.0,
            ),
            RoundedTextField(
              validator: (val) => Validate.passwordValidate(val),
              controller: _txtNewPass,
              isPassword: true,
              hintText: LocaleKeys.password_confirm.tr(),
              label: LocaleKeys.new_password.tr(),
            ),
            SizedBox(height: 25.0),
            RoundedTextField(
              validator: (val) =>
                  Validate.reEnterPasswordValidate(val, _txtNewPass.text),
              controller: _txtConfirm,
              isPassword: true,
              hintText: LocaleKeys.password_confirm.tr(),
              label: LocaleKeys.password_confirm.tr(),
            ),
            SizedBox(
              height: 50.0,
            ),
            PillButton(
              child: Text(LocaleKeys.change_password.tr()),
              onPressed: onChangePassword,
            )
          ],
        ),
      ),
    );
  }
}
