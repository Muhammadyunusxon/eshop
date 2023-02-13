
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class BottomConvexBar extends StatelessWidget {
  final ValueChanged<int> onChanged;
  const BottomConvexBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      color: kBrandColor,
      backgroundColor: kWhiteColor,
      style: TabStyle.fixedCircle,
      items: [
        TabItem(
          icon: SvgPicture.asset("assets/svg/home.svg"),
          activeIcon:
          SvgPicture.asset("assets/svg/home.svg", color: kBrandColor),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/search.svg"),
          activeIcon:
          SvgPicture.asset("assets/svg/search.svg", color: kBrandColor),
        ),
        TabItem(
          icon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset("assets/svg/scan.svg")),
          activeIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset("assets/svg/scan.svg",
                  color: kBrandColor)),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/favourite_outline.svg"),
          activeIcon: SvgPicture.asset("assets/svg/favourite_outline.svg",
              color: kBrandColor),
        ),
        TabItem(
          icon: SvgPicture.asset("assets/svg/person.svg"),
          activeIcon:
          SvgPicture.asset("assets/svg/person.svg", color: kBrandColor),
        ),
      ],
      initialActiveIndex: 0,
      onTap: onChanged,
    );
  }
}
