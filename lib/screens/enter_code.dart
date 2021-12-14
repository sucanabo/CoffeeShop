import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:easy_localization/easy_localization.dart';
class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(LocaleKeys.enter_code.tr()),
          centerTitle: true,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(
                    bottom: 60.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Colors.grey[100]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: LineIcon.alternateTicket(
                        size: 50.0,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      LocaleKeys.hint_enter_to_receive_voucher.tr(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 40.0,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            hintText: LocaleKeys.enter_code_here.tr(),
                            suffixIcon: LineIcon.qrcode(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryMediumColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () => Navigator.pop(context),
                        child: Text(LocaleKeys.apply.tr()))
                  ],
                ),
              ))
            ]));
  }
}
