import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/style.dart';
class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset("assets/svg/arrow_back.svg"),
          ),
          Text(
            "All",
            style: Style.textStyleSemiBold(size: 18),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/svg/search.svg", height: 16),
          ),
        ],
      ),
    );
  }
}
