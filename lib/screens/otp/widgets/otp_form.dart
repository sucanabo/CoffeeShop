import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPForm extends StatelessWidget {
  OTPForm({this.otpController, this.onComplete,this.onChanged});
  final TextEditingController otpController;
  final Function(String) onComplete;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: PinCodeTextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autoFocus: true,
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 100),
        controller: otpController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 40,
            fieldWidth: 40,
            activeColor: Colors.green,
            borderWidth: 0.5,
            borderRadius: BorderRadius.circular(8.0)),
        onChanged: onChanged,
        onCompleted: onComplete,
      ),
    );
  }
}
