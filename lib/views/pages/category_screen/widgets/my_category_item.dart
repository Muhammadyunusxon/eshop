import 'package:eshop/domen/model/category_model.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/components/my_image_network.dart';
import '../../../utils/style.dart';
import '../category_products.dart';

class MyCategoryItem extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final bool isFavPage;

  const MyCategoryItem(
      {Key? key,
      required this.category,
      required this.index,
      this.isFavPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CategoryProducts(
                  categoryModel: category,
                )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r), color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 25.w,
              ),
              decoration: const BoxDecoration(
                color: Style.productBgColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              padding: const EdgeInsets.all(20),
              child: CustomImageNetwork(
                height: 65.h,
                image: category.image,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                (category.name?.substring(0, 1).toUpperCase() ?? "") +
                    (category.name?.substring(1) ?? ""),
                overflow: TextOverflow.ellipsis,
                style: Style.textStyleSemiBold(size: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
