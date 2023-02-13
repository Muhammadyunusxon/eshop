import 'package:eshop/domen/model/product_model.dart';
import 'package:eshop/views/pages/product_screen/product_page.dart';
import 'package:eshop/views/utils/components/my_image_network.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utils/style.dart';

class SearchProductItem extends StatelessWidget {
  final ProductModel product;

  const SearchProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductPage(
                    product: product,
                  )));
        },
        child: Container(
          height: 60,
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: kWhiteColor),
          child: Row(
            children: [
              CustomImageNetwork(
                image: product.image,
                height: 55,
                width: 55,
                radius: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    (product.name?.substring(0, 1).toUpperCase() ?? "") +
                        (product.name?.substring(1) ?? ""),
                    overflow: TextOverflow.ellipsis,
                    style: Style.textStyleNormal(size: 14),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  NumberFormat.currency(
                          locale: 'en', symbol: "\$", decimalDigits: 0)
                      .format(product.price),
                  style: Style.textStyleNormal(size: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
