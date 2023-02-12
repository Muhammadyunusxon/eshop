import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/utils/components/my_image_network.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  ProductModel? newProduct;
  bool isLoading = false;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    if (widget.product != null) {
      newProduct = widget.product;
    } else {
      getSingleProduct();
    }
    super.initState();
  }

  getSingleProduct() async {
    isLoading = true;
    setState(() {});
    var res =
        await firebaseFirestore.collection("products").doc(widget.docId).get();
    newProduct = ProductModel.fromJson(data: res.data(), id: res.id);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Style.productBgColor,
      appBar: AppBar(
        backgroundColor: kBrandColor,
        title: const Text("Product"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: kBrandColor,))
          : ListView(
              children: [
                Container(
                  height: (SizeConfig.screenHeight ?? 1) / 2.6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: CustomImageNetwork(
                    image: newProduct?.image ?? "",
                    radius: 0,
                    width: double.infinity,
                  ),
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
                        (newProduct?.name?.substring(0, 1).toUpperCase() ??
                                "") +
                            (newProduct?.name?.substring(1) ?? ""),
                        style: Style.textStyleSemiBold(size: 22),
                      ),
                      12.h.verticalSpace,
                      Text(
                        NumberFormat.currency(
                                locale: 'en', symbol: "\$", decimalDigits: 0)
                            .format(newProduct?.price),
                        style: Style.textStyleSemiBold(),
                      ),
                      16.h.verticalSpace,
                      Text("${newProduct?.desc}"),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
