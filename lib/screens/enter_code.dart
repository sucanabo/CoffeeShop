import 'package:coffee_shop/values/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class EnterCodeScreen extends StatelessWidget {
  const EnterCodeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Enter promotion code'),
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
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'You can enter code to receive Voucher',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 40.0,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            hintText: 'Enter code here',
                            suffixIcon: LineIcon.qrcode(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryMediumColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Apply'))
                  ],
                ),
              ))
            ]));
  }
}
