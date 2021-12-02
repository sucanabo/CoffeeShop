import 'package:coffee_shop/values/color_theme.dart';
import 'package:coffee_shop/values/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../res.dart';

// ignore: must_be_immutable
class RoundedTextField extends StatefulWidget {
  RoundedTextField(
      {this.hintText,
      this.prefixIcon,
      this.label,
      this.keyboardType,
      this.textInputAction,
      this.inputFormatters,
      @required this.controller,
      this.validator,
      this.readOnly = false,
      this.enabled = true,
      this.isDate = false,
      this.isPassword = false,
      this.onTapTextField,
      this.onChanged,
      this.clearChanged,
      this.suffix,
      this.maxLine = 1,
      this.paddingContent,
      this.autoFocus = false,
      this.clearButton = true});
  final String hintText;
  final String label;
  final String prefixIcon;
  final bool isPassword;
  final bool isDate;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final String Function(String) validator;
  final Function() onTapTextField;
  final Function(String) onChanged;
  final Function clearChanged;
  final Widget suffix;
  final bool enabled;
  final bool autoFocus;
  final bool clearButton;
  int maxLine;
  final EdgeInsets paddingContent;
  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _showPassword = false;
  bool _showClearButton = false;
  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {
        _showClearButton = widget.controller.text.length > 0;
      });
    });

    super.initState();
  }

  showCustomDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        widget.controller.text = formatDateToString(value);
      }
    });
  }

  Function() _getOnTap() {
    if (widget.onTapTextField != null) return widget.onTapTextField;
    if (widget.isDate) return showCustomDatePicker;
    return () {};
  }

  Widget _getClearButton() {
    if (!_showClearButton || !widget.clearButton)
      return const SizedBox.shrink();
    return IconButton(
        onPressed: () {
          widget.controller?.clear();
        },
        icon: SvgPicture.asset(
          Res.ic_close_circle,
          color: Colors.black.withOpacity(0.36),
          fit: BoxFit.fitWidth,
          width: 24,
          height: 24,
        ));
  }

  _getPasswordButton() {
    if (!widget.isPassword) return const SizedBox.shrink();
    return IconButton(
      onPressed: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      icon: SvgPicture.asset(
        _showPassword ? Res.ic_eye_slash : Res.ic_eye,
        color: Colors.black.withOpacity(0.36),
        width: 24,
        height: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ?? null,
      keyboardType: widget.keyboardType,
      style: TextStyle(fontSize: 14.0),
      obscureText: widget.isPassword && !_showPassword,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: widget.maxLine,
      onTap: _getOnTap(),
      onChanged: widget.onChanged,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        contentPadding:
            widget.paddingContent ?? EdgeInsets.symmetric(horizontal: 15.0),
        suffixIcon: widget.suffix ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getPasswordButton(),
                if (!widget.readOnly) _getClearButton(),
                if (widget.isDate)
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SvgPicture.asset(
                      Res.ic_calendar,
                      height: 24,
                      width: 24,
                      color: AppColors.blackColor.withOpacity(0.6),
                    ),
                  )
              ],
            ),
        prefixIcon: widget.prefixIcon != null
            ? SizedBox(
                height: 10.0,
                width: 10.0,
                child: Align(
                  child: SvgPicture.asset(
                    widget.prefixIcon,
                    color: AppColors.mutedColor,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        labelText: widget.label,
        labelStyle: TextStyle(
            color: AppColors.textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.textColor),
            gapPadding: 10.0),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey[400]),
            gapPadding: 10.0),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.red),
            gapPadding: 10.0),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.redColor),
            gapPadding: 10.0),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: AppColors.primaryColor),
            gapPadding: 10.0),
        helperStyle:
            TextStyle(color: Colors.red[300], fontWeight: FontWeight.w500),
        helperMaxLines: 1,
      ),
    );
  }
}
