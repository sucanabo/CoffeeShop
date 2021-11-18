import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/widgets/pill_button.dart';
import 'package:coffee_shop/widgets/popup_menu_item.dart';
import 'package:coffee_shop/widgets/rounded_button.dart';
import 'package:coffee_shop/widgets/rounded_text_field.dart';
import 'package:coffee_shop/widgets/screen_body.dart';
import 'package:coffee_shop/widgets/screen_body_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../values/api_end_point.dart';

class AddressDetail extends StatefulWidget {
  final bool isEdit;
  final AddressModel address;
  AddressDetail({@required this.isEdit, this.address});

  @override
  _AddressDetailState createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtTitle = TextEditingController();
  TextEditingController _txtAddress = TextEditingController();
  TextEditingController _txtDescription = TextEditingController();
  TextEditingController _txtReceiverName = TextEditingController();
  TextEditingController _txtReceiverPhone = TextEditingController();

  AddressModel _address;
  void submitForm(AddressModel address) async {
    int result = widget.isEdit
        ? await Provider.of<AuthProvider>(context, listen: false)
            .updateAddress(context, address: address, id: widget.address.id)
        : await Provider.of<AuthProvider>(context, listen: false)
            .createAddress(context, address: address);
    if (result != -1) {
      Navigator.of(context).pop(result);
      showToast(widget.isEdit ? 'Updated success' : 'Create success');
    } else {
      showToast(widget.isEdit ? 'Updated failed' : 'Updated failed');
    }
    setState(() {
      _loading = false;
    });
  }

  void deleteAdddress() async {
    String result = await Provider.of<AuthProvider>(context, listen: false)
        .deleteAddress(widget.address.id);
    if (result != null) {
      if (result == unauthorized) {
        logout(context).then((value) => {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false)
            });
      } else {
        showMess(context: context, text: result);
      }
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/address'));
      showMess(context: context, text: 'Delete success');
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _address = widget.address;
      _txtTitle.text = _address.title;
      _txtAddress.text = _address.address;
      _txtDescription.text = _address.description;
      _txtReceiverName.text = _address.receiverName;
      _txtReceiverPhone.text = _address.receiverPhone;
    } else {
      final user = Provider.of<AuthProvider>(context, listen: false).getUser;
      _txtReceiverName.text = '${user.displayName}';
      _txtReceiverPhone.text = user.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<AppBarPopupItem> appBarActions = [
      AppBarPopupItem(
          text: 'Delete', icon: Icons.delete, onPressed: openDeleteDialog)
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isEdit ? 'Edit address' : 'Add address'),
          actions: widget.isEdit ? [_buildDeleteAction(appBarActions)] : [],
        ),
        body: _loading
            ? ScreenBodyLoading()
            : ScreenBody(
                child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Address Information',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter title';
                              }
                              if (value.length > 500)
                                return 'Title length must in 500 character';
                              return null;
                            },
                            controller: _txtTitle,
                            hintText: 'Name of address',
                            label: 'Address title',
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              if (value.length > 500)
                                return 'Title length must in 500 character';
                              return null;
                            },
                            maxLine: 5,
                            paddingContent: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            controller: _txtAddress,
                            hintText: 'Address',
                            label: 'Address',
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value.length > 500)
                                return 'Title length must in 500 character';
                              return null;
                            },
                            paddingContent: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            controller: _txtDescription,
                            maxLine: 5,
                            hintText: 'More desciption about your address',
                            label: 'Description',
                            textInputAction: TextInputAction.next,
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.5,
                          ),
                          Text(
                            'Receiver Information',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter receiver\'s name';
                              }
                              if (value.length > 255)
                                return 'Title length must in 255 character';
                              return null;
                            },
                            controller: _txtReceiverName,
                            hintText: 'Receiver\'s name',
                            label: 'Receiver',
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter receiver\'s phone number';
                              }
                              if (value.length > 11 || value.length < 10)
                                return 'Invalid phone number (10 or 11 numbers)';
                              return null;
                            },
                            controller: _txtReceiverPhone,
                            keyboardType: TextInputType.phone,
                            hintText: 'Receiver\'s phone',
                            label: 'Phone number',
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          PillButton(
                              child: Text('OK'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  final address = AddressModel(
                                      title: _txtTitle.text,
                                      address: _txtAddress.text,
                                      description: _txtDescription.text,
                                      receiverName: _txtReceiverName.text,
                                      receiverPhone: _txtReceiverPhone.text);
                                  submitForm(address);
                                }
                              },
                              color: AppColors.primaryColor)
                        ],
                      ))
                ],
              )));
  }

  void openDeleteDialog() {
    showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: Text('Delete Address'),
              content: Text('Are you sure delete ${widget.address.title} ?'),
              actions: [
                RoundedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(dialogContext);
                      _loading = true;
                      deleteAdddress();
                    });
                  },
                  title: 'Yes',
                  color: AppColors.primaryColor,
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  title: 'No',
                  color: AppColors.darkColor,
                ),
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ));
  }

  PopupMenuButton<dynamic> _buildDeleteAction(
      List<AppBarPopupItem> appBarActions) {
    return PopupMenuButton(
        itemBuilder: (context) => appBarActions
            .map((item) => PopupMenuItem(
                  child: InkWell(
                    onTap: item.onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.text),
                        Icon(
                          item.icon,
                          color: AppColors.textColor,
                          size: 18.0,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList());
  }
}
