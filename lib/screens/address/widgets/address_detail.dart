import 'package:coffee_shop/models/address.dart';
import 'package:coffee_shop/providers/auth_provider.dart';
import 'package:coffee_shop/screens/address/address_screen.dart';
import 'package:coffee_shop/screens/google_map_screen.dart';
import 'package:coffee_shop/screens/sign_in/sign_in_screen.dart';
import 'package:coffee_shop/services/user_service.dart';
import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:coffee_shop/values/validate.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:coffee_shop/translations/locale_keys.g.dart';

class AddressDetail extends StatefulWidget {
  final bool isEdit;
  final AddressModel address;

  AddressDetail({@required this.isEdit, this.address});

  @override
  _AddressDetailState createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  bool _loading = false;
  LocationAddress coordinate;
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
      showToast(
        widget.isEdit
            ? LocaleKeys.update_success.tr()
            : LocaleKeys.create_success.tr(),
      );
    } else {
      showToast(
        widget.isEdit
            ? LocaleKeys.update_fail.tr()
            : LocaleKeys.create_fail.tr(),
      );
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
      Navigator.popUntil(context, ModalRoute.withName(AddressScreen.routeName));
      showMess(context: context, text: LocaleKeys.delete_success.tr());
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
      coordinate = LocationAddress(
          address: _address.address, coordinates: _address.coordinates);
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
          text: LocaleKeys.delete.tr(),
          icon: Icons.delete,
          onPressed: openDeleteDialog)
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.isEdit
              ? '${LocaleKeys.update.tr() + LocaleKeys.address.tr()}'
              : LocaleKeys.add_address.tr()),
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
                            LocaleKeys.address_information.tr(),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.validate_not_null.tr();
                              }
                              if (value.length > 500)
                                return LocaleKeys.validate_length_500.tr();
                              return null;
                            },
                            controller: _txtTitle,
                            hintText: LocaleKeys.address_name.tr(),
                            label: LocaleKeys.address_name.tr(),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.validate_not_null.tr();
                              }
                              if (value.length > 500)
                                return LocaleKeys.validate_length_500.tr();
                              return null;
                            },
                            maxLine: 5,
                            paddingContent: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 15.0),
                            controller: _txtAddress,
                            autoFocus: false,
                            onTapTextField: () async {
                              dynamic result = await Navigator.of(context)
                                  .pushNamed(GoogleMapScreen.routeName,
                                      arguments: coordinate);
                              print(result);
                              if (result != null) {
                                _txtAddress.text = result.address;
                                setState(() {
                                  coordinate = result;
                                });
                              }
                            },
                            readOnly: true,
                            hintText: LocaleKeys.address.tr(),
                            label: LocaleKeys.address.tr(),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value.length > 500)
                                return LocaleKeys.validate_length_500.tr();
                              return null;
                            },
                            paddingContent: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            controller: _txtDescription,
                            maxLine: 5,
                            hintText: LocaleKeys.more_description.tr(),
                            label: LocaleKeys.more_description.tr(),
                            textInputAction: TextInputAction.next,
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.5,
                          ),
                          Text(
                            LocaleKeys.receiver_info.tr(),
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.validate_not_null.tr();
                              }
                              if (value.length > 255)
                                return LocaleKeys.validate_length_255.tr();
                              return null;
                            },
                            controller: _txtReceiverName,
                            hintText: LocaleKeys.receiver_name.tr(),
                            label: LocaleKeys.receiver_name.tr(),
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 20.0),
                          RoundedTextField(
                            validator: (value) => Validate.phoneValidate(value),
                            controller: _txtReceiverPhone,
                            keyboardType: TextInputType.phone,
                            hintText: LocaleKeys.receiver_phone.tr(),
                            label: LocaleKeys.receiver_phone.tr(),
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          PillButton(
                              child: Text(LocaleKeys.ok.tr()),
                              onPressed: () {
                                print(coordinate);
                                if (_formKey.currentState.validate() &&
                                    coordinate != null) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  final address = AddressModel(
                                      title: _txtTitle.text,
                                      address: _txtAddress.text,
                                      description: _txtDescription.text,
                                      receiverName: _txtReceiverName.text,
                                      receiverPhone: _txtReceiverPhone.text,
                                      coordinates: coordinate.coordinates);
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
              title: Text(LocaleKeys.delete.tr() + LocaleKeys.address),
              content: Text(
                  ' ${LocaleKeys.are_you_sure.tr()} ${LocaleKeys.delete.tr() + LocaleKeys.address.tr()} ${widget.address.title} ?'),
              actions: [
                RoundedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(dialogContext);
                      _loading = true;
                      deleteAdddress();
                    });
                  },
                  title: LocaleKeys.yes.tr(),
                  color: AppColors.primaryColor,
                ),
                RoundedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  title: LocaleKeys.no.tr(),
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
