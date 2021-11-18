import 'package:coffee_shop/screens/address/widgets/address_detail.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/pop_up_notify.dart';
import 'package:flutter/material.dart';

class CheckOutPopUp {
  static addressNull(BuildContext context, Function changeAddress) {
    showDialog(
        context: context,
        builder: (popupContext) => PopUpNotify(
              title: 'Opps!!!',
              content: Text('You have not added any addresses yet. Add now '),
              actions: [
                PillButton(
                  child: Text('Add address'),
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
