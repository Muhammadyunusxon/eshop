import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class MyDropDown extends StatelessWidget {
  final String? value;
  final String hint;
  final List list;
  final ValueChanged onChanged;

  const MyDropDown(
      {Key? key,
        this.value,
        required this.list,
        required this.onChanged,
        required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text(
        hint,
        style: Style.textStyleNormal(textColor: kBrandColor.withOpacity(0.7)),
      ),
      value: value,
      items: list.map((e) {
        return DropdownMenuItem(value: e, child: Text(e));
      }).toList(),
      onChanged: onChanged,
      dropdownColor: kWhiteColor,
      iconEnabledColor: kBrandColor,
      borderRadius: BorderRadius.circular(14),
      style: Style.textStyleNormal(textColor: kBrandColor),
      decoration: Style.myDecoration(title: "Kategoriya"),
    );
  }
}