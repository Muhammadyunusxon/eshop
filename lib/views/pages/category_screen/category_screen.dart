import 'package:eshop/views/pages/category_screen/widgets/my_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            20.verticalSpace,
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
      ),
    );
  }
}
