import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';

import '../constants.dart';
import '../style.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? titleColor;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChange;
  final ValueChanged<num>? onValueChange;
  final bool formatter;

  const MyFormFiled(
      {Key? key,
      required this.controller,
      required this.title,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.titleColor,
      this.fillColor,
      this.suffix,
      this.prefix,
      this.borderColor,
      this.suffixIcon,
      this.onChange,
      this.formatter = false, this.onValueChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter ? [
        LengthLimitingTextInputFormatter(4),
        CurrencyInputFormatter(mantissaLength: 0,onValueChange: onValueChange)] : [
      ],
      onChanged: onChange,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controller,
      style: Style.textStyleNormal(textColor: kTextDarkColor),
      decoration: Style.myDecoration(
          title: title,
          titleColor: titleColor,
          fillColor: fillColor,
          suffixIcon: suffix,
          borderColor: borderColor,
          prefixIcon: prefix),
    );
  }
}
