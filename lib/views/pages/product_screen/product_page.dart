import 'package:eshop/views/utils/components/my_image_network.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../domen/model/product_model.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';

class ProductPage extends StatefulWidget {
  final ProductModel? product;
  final String? docId;

  const ProductPage({Key? key, this.product, this.docId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {

    if (widget.product != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().changeSingleProduct(widget.product!);

      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().getSingleProduct(widget.docId);
      });
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Style.productBgColor,
      appBar: AppBar(
        backgroundColor: kBrandColor,
        title: const Text("Product"),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/svg/share.svg",
                height: 20, color: kWhiteColor),
            onPressed: () {
              event.createDynamicLink(state.singleProduct!);
            },
          ),
          12.w.horizontalSpace
        ],
      ),
      body: state.isSingleProductLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: kBrandColor,
            ))
          : ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: (SizeConfig.screenHeight ?? 1) / 2.6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: CustomImageNetwork(
                        image: state.singleProduct?.image ?? "",
                        radius: 0,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                        right: 20,
                        bottom: 20,
                        child: IconButton(
                          icon: SvgPicture.asset(
                              "assets/svg/${(state.singleProduct?.isLike ?? false) ? "favourite" : "favourite_outline"}.svg"),
                          onPressed: () {
                            context.read<HomeController>().changeLike(product: state.singleProduct, index: 0);
                          },
                        )),
                  ],
                ),
                Container(
                  height: (SizeConfig.screenHeight ?? 1) / 1.8,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18.r))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (state.singleProduct?.name?.substring(0, 1).toUpperCase() ??
                                "") +
                            (state.singleProduct?.name?.substring(1) ?? ""),
                        style: Style.textStyleSemiBold(size: 22),
                      ),
                      12.h.verticalSpace,
                      Text(
                        NumberFormat.currency(
                                locale: 'en', symbol: "\$", decimalDigits: 0)
                            .format(state.singleProduct?.price),
                        style: Style.textStyleSemiBold(),
                      ),
                      16.h.verticalSpace,
                      Text("${state.singleProduct?.desc}"),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
