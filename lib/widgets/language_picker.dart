import 'package:coffee_shop/providers/provider.dart';
import 'package:coffee_shop/untils/languages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    print(context.locale.languageCode);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: context.locale,
        icon: Container(
          width: 12,
        ),
        items: Languages.localizations.map((locale) {
          final flag = Languages.getFlag(locale.languageCode);
          return DropdownMenuItem(
            child: Center(
              child: Text(
                flag,
                style: TextStyle(fontSize: 32),
              ),
            ),
            value: locale,
            onTap: () {
              langProvider.changeLanguage(context, locale);
            },
          );
        }).toList(),
        onChanged: (val) {},
      ),
    );
  }
}
