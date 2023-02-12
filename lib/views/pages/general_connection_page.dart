import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:eshop/views/pages/add_product/add_product.dart';
import 'package:eshop/views/pages/product_screen/all_product_screen.dart';
import 'package:eshop/views/pages/product_screen/favourite_screen.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

// ignore: must_be_immutable
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProsteIndexedStack(
          index: current,
          children: [
            IndexedStackChild(child: const AllProductScreen()),
            IndexedStackChild(child: const Placeholder()),
            IndexedStackChild(
              child: const AddProductPage(),
            ),
            IndexedStackChild(child: const FavouriteScreen()),
            IndexedStackChild(child: const Placeholder()),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          color: kBrandColor,
          backgroundColor: kWhiteColor,
          style: TabStyle.fixedCircle,
          items: [
            TabItem(
              icon: SvgPicture.asset("assets/svg/home.svg"),
              activeIcon:
                  SvgPicture.asset("assets/svg/home.svg", color: kBrandColor),
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svg/search.svg"),
              activeIcon:
                  SvgPicture.asset("assets/svg/search.svg", color: kBrandColor),
            ),
            TabItem(
              icon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset("assets/svg/scan.svg")),
              activeIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset("assets/svg/scan.svg",
                      color: kBrandColor)),
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svg/favourite_outline.svg"),
              activeIcon: SvgPicture.asset("assets/svg/favourite_outline.svg",
                  color: kBrandColor),
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svg/person.svg"),
              activeIcon:
                  SvgPicture.asset("assets/svg/person.svg", color: kBrandColor),
            ),
          ],
          initialActiveIndex: 0,
          onTap: (int i) => setState(
            () => current = i,
          ),
        ));
  }
}
