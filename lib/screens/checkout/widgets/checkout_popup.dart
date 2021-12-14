import 'package:coffee_shop/screens/address/widgets/address_detail.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/pop_up_notify.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class CheckOutPopUp {
  static addressNull(BuildContext context, Function changeAddress) {
    showDialog(
        context: context,
        builder: (popupContext) => PopUpNotify(
              title: LocaleKeys.opps.tr(),
              content: Text(LocaleKeys.not_address_yet.tr()),
              actions: [
                PillButton(
                  child: Text(LocaleKeys.add.tr()),
                  onPressed: () async {
                    Navigator.of(popupContext).pop();
                    final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                AddressDetail(isEdit: false)));
                    changeAddress(result);
                  },
                )
              ],
            ));
  }
}
