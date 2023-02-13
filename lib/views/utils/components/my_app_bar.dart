import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/pages/product_screen/widgets/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class MyAppBar extends StatelessWidget {
  final String categoryName;

  const MyAppBar({Key? key, this.categoryName = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
      child: Row(
        children: [
          categoryName.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset("assets/svg/arrow_back.svg"),
                )
              : const SizedBox.shrink(),
          const Spacer(),
          Wrap(
            spacing: 5,
            children: [
              for (int i = 0; i < state.listOfSelectIndex.length; i++)
                Text(
                  state.listOfSelectIndex[i].name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Style.textStyleSemiBold(size: 16),
                ),
            ],
          ),
          Text(
            state.setFilter
                ? ""
                : categoryName.isNotEmpty
                    ? categoryName
                    : "All",
            style: Style.textStyleSemiBold(size: 18),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => const SearchFilter());
            },
            icon: SvgPicture.asset("assets/svg/search.svg", height: 16),
          ),
        ],
      ),
    );
  }
}
