import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/pages/product_screen/widgets/price_range.dart';
import 'package:eshop/views/utils/components/my_form_field.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:eshop/views/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  late TextEditingController _searchController;
  late TextEditingController _fromController;
  late TextEditingController _toController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            31.h.verticalSpace,
            Text("Filter", style: Style.textStyleSemiBold(size: 18)),
            20.h.verticalSpace,
            MyFormFiled(
              onChange: (s){
                event.searchProduct(s);
              },
              controller: _searchController,
              title: "Search",
              fillColor: kMediumColor,
              titleColor: kTextDarkColor.withOpacity(0.6),
              prefix: SvgPicture.asset("assets/svg/search.svg"),
            ),
            20.verticalSpace,
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (int i = 0; i < state.listOfCategory.length; i++)
                  GestureDetector(
                    onTap: () {
                      event.changeIndex(i);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: state.selectIndex == i
                              ? kBrandColor
                              : kMediumColor,
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
                      child: Text(
                        state.listOfCategory[i].name ?? "",
                        style: Style.textStyleNormal(size: 15.5),
                      ),
                    ),
                  )
              ],
            ),
            18.h.verticalSpace,
           PriceRange(fromController: _fromController, toController: _toController),
            24.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
