import 'package:coffee_shop/models/models.dart';
import 'package:coffee_shop/screens/address/widgets/address_detail.dart';
import 'package:coffee_shop/values/values.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final AddressModel address;
  final bool isChooseAddress;
  AddressItem({@required this.address, this.isChooseAddress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        !isChooseAddress
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddressDetail(
                          isEdit: true,
                          address: address,
                        )),
              )
            : Navigator.pop(context, {'id': address.id});
      },
      splashColor: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            address.title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            address.address,
            style: TextStyle(fontSize: 16.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
