import 'package:eshop/domen/model/product_model.dart';
import 'package:eshop/views/pages/product_screen/product_page.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../style.dart';
import 'my_image_network.dart';

class MyProduct extends StatelessWidget {
  final ProductModel product;
  final int index;
  final bool isFavPage;

  const MyProduct(
      {Key? key,
      required this.product,
      required this.index,
      this.isFavPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        context.read<HomeController>().createDynamicLink(product);
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductPage(
                  product: product,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r), color: kWhiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Style.productBgColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                  child: CustomImageNetwork(
                    height: 100,
                    image: product.image,
                  ),
                ),
                Positioned(
                    right: 0,
                    child: IconButton(
                      icon: SvgPicture.asset(
                          "assets/svg/${product.isLike ? "favourite" : "favourite_outline"}.svg"),
                      onPressed: () {
                        context
                            .read<HomeController>()
                            .changeLike(index: index, isFav: isFavPage);
                      },
                    )),
              ],
            ),
            5.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                (product.name?.substring(0, 1).toUpperCase() ?? "") +
                    (product.name?.substring(1) ?? ""),
                overflow: TextOverflow.ellipsis,
                style: Style.textStyleNormal(size: 14),
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
    );
  }
}
