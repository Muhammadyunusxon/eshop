import 'package:flutter/material.dart';

import '../constants.dart';
import '../style.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  const MyFormFiled(
      {Key? key, required this.controller, required this.title, this.textInputAction = TextInputAction
          .done,  this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType:textInputType,
      controller: controller,
      style: Style.textStyleNormal(textColor: kBrandColor),
      decoration: Style.myDecoration(title: title),
    );
  }
}