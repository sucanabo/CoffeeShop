import 'package:coffee_shop/models/api_response.dart';
import 'package:coffee_shop/res.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/size_config.dart';
import 'package:coffee_shop/values/validate.dart';
import 'package:coffee_shop/widgets/rounded_button.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/sign_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class Body extends StatefulWidget {
  Body({this.phone});
  final String phone;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    widget.phone != null
        ? _sendMail(widget.phone)
        : showToast(LocaleKeys.phone_invalid.tr(),
            toastLength: Toast.LENGTH_LONG);
  }

  _sendMail(String phone) async {
    ApiResponse res = await sendMailReset(phone: phone);
    showToast(res.data, toastLength: Toast.LENGTH_LONG);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenBody(
        child: ListView(
          padding: EdgeInsets.all(getWidth(20.0)),
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                LocaleKeys.forgot_password.tr(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: getWidth(28.0),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                LocaleKeys.hint_please_checkmail.tr(),
                textAlign: TextAlign.center,
              )
            ]),
            SizedBox(height: SizeConfig.screenHeigh * 0.1),
            ForgotPassForm(),
            SizedBox(
              height: SizeConfig.screenHeigh * 0.025,
            ),
            Text(LocaleKeys.hint_please_check_spam.tr()),
            SizedBox(
              height: SizeConfig.screenHeigh * 0.005,
            ),
            Text(hiddenEmail('sucanabo@gmail.com')),
            SizedBox(
              height: SizeConfig.screenHeigh * 0.025,
            ),
            RoundedButton.outline(
              title: LocaleKeys.resend_email.tr(),
              onPressed: () => _sendMail,
              color: AppColors.primaryColor,
              textColor: AppColors.primaryColor,
            ),
            SizedBox(height: SizeConfig.screenHeigh * 0.1),
            SignButton(text: LocaleKeys.sign_in.tr(), onSubmit: () {}),
            SizedBox(height: SizeConfig.screenHeigh * 0.1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.not_receive_email.tr()),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  style: TextButton.styleFrom(
                      alignment: Alignment.topCenter, padding: EdgeInsets.zero),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.send_otp.tr(),
                            style:
                                TextStyle(color: AppColors.primaryMediumColor)),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.primaryMediumColor,
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  ForgotPassForm({Key key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  TextEditingController _txtNewPassword = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Column(
        children: [
          RoundedTextField(
            hintText: LocaleKeys.enter_your_password.tr(),
            controller: _txtNewPassword,
            prefixIcon: Res.ic_lock,
            validator: (value) => Validate.emailValidate(value),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          )
        ],
      ),
    );
  }
}
