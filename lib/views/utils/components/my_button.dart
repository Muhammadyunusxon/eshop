import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;

  const MyButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r), color: kBrandColor),
        child: isLoading
            ? const CircularProgressIndicator(
                color: kWhiteColor,
              )
            : Center(
                child: Text(
                title,
                style: Style.textStyleSemiBold(textColor: kWhiteColor),
              )),
      ),
    );
  }
}
