import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/home_controller.dart';
import '../../utils/components/my_product.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      event.getFavourites();
    });
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrandColor,
        title: Text(
          "Favourite",
          style: Style.textStyleNormal(textColor: kWhiteColor, size: 22),
        ),
      ),
      body: state.listOfFavouriteProduct.isEmpty
          ? Column(
              children: [
                ((SizeConfig.screenHeight!) ~/ 5).toInt().verticalSpace,
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth! / 7,
                      right: SizeConfig.screenWidth! / 3),
                  child: Image.asset("assets/images/favourite.png"),
                ),
                Text(
                  "Not found",
                  style: Style.textStyleNormal(
                      textColor: kTextDarkColor.withOpacity(0.8)),
                )
              ],
            )
          : GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.listOfFavouriteProduct.length,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 175,
                  mainAxisSpacing: 16),
              itemBuilder: (context, index) {
                return MyProduct(
                  product: state.listOfFavouriteProduct[index],
                  index: index,
                  isFavPage: true,
                );
              }),
    );
  }
}
