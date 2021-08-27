import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/address/widgets/address_detail.dart';
import 'package:coffee_shop/screens/address/widgets/address_item.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final bool isChooseAddress;
  const Body({this.isChooseAddress});
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (context, provider, child) => ScreenBody(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAddNew(context),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(child: _buildAddressItems(provider)),
                ],
              ),
            ));
  }

  InkWell _buildAddNew(context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddressDetail(isEdit: false)));
        },
        splashColor: primaryColor,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Add new',
            style: TextStyle(
                fontSize: 20.0,
                color: primaryColor,
                fontWeight: FontWeight.bold),
          ),
          LineIcon.plus(),
        ]));
  }

  ListView _buildAddressItems(provider) {
    return ListView.separated(
      itemCount: provider.addresses.length,
      itemBuilder: (context, index) => AddressItem(
        address: provider.addresses[index],
        isChooseAddress: isChooseAddress,
      ),
      separatorBuilder: (context, index) => Divider(
        height: 25,
        thickness: 1.5,
      ),
    );
  }
}
