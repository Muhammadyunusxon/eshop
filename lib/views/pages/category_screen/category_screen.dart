import 'package:eshop/views/pages/category_screen/widgets/my_category_item.dart';
import 'package:eshop/views/pages/category_screen/widgets/serach_product_item.dart';
import 'package:eshop/views/utils/components/my_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            20.verticalSpace,
            MyFormFiled(
              onChange: (s) {
                event.searchProduct(s);
              },
              controller: searchController,
              title: "Search",
              fillColor: kWhiteColor,
              titleColor: kTextDarkColor.withOpacity(0.6),
              prefix: SvgPicture.asset("assets/svg/search.svg"),
            ),
            Expanded(
              child: state.setFilter ? ListView.builder(
                itemCount: state.listOfProduct.length,
                  itemBuilder: (context, index) {
                    return  SearchProductItem(product: state.listOfProduct[index],);
                  }) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: Style.textStyleSemiBold(size: 21),
                  ),
                  Expanded(
                    child: state.isLoading
                        ? const Center(
                        child: CircularProgressIndicator(
                          color: kBrandColor,
                        ))
                        : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listOfCategory.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 18),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisExtent: 175,
                            mainAxisSpacing: 16),
                        itemBuilder: (context, index) {
                          return MyCategoryItem(
                            category: state.listOfCategory[index],
                            index: index,
                          );
                        }),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
