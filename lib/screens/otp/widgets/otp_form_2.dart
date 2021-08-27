import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPForm2 extends StatefulWidget {
  // OTPForm2({Key? key}) : super(key: key);
  final Function onChange;
  OTPForm2({this.onChange});
  @override
  _OTPForm2State createState() => _OTPForm2State();
}

class _OTPForm2State extends State<OTPForm2> {
  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listenOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PinFieldAutoFill(
      codeLength: 4,
      onCodeChanged: (value) {
        widget.onChange(value);
      },
    ));
  }
}
