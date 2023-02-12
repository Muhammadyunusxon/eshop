import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/pages/product_screen/widgets/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../utils/style.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Text(
           state.setFilter? state.listOfCategory[state.selectIndex].name ?? '':"All",
            style: Style.textStyleSemiBold(size: 18),
          ),
          IconButton(
            onPressed: () {
              showBottomSheet(
                backgroundColor: Colors.transparent,
                  context: context, builder: (context) => const SearchFilter());
            },
            icon: SvgPicture.asset("assets/svg/search.svg", height: 16),
          ),
        ],
      ),
    );
  }
}
