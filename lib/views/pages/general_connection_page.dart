import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/pages/add_product/add_product.dart';
import 'package:eshop/views/pages/product_screen/all_product_screen.dart';
import 'package:eshop/views/pages/product_screen/favourite_screen.dart';
import 'package:eshop/views/pages/product_screen/product_page.dart';
import 'package:eshop/views/utils/components/bottom_convex_bar.dart';
import 'package:flutter/material.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';
import 'package:provider/provider.dart';

import 'category_screen/category_screen.dart';

// ignore: must_be_immutable
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int current = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().initDynamicLinks((docId) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ProductPage(docId: docId)));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProsteIndexedStack(
          index: current,
          children: [
            IndexedStackChild(child: const AllProductScreen()),
            IndexedStackChild(child: const CategoryScreen()),
            IndexedStackChild(child: const AddProductPage()),
            IndexedStackChild(child: const FavouriteScreen()),
            IndexedStackChild(child: const Placeholder()),
          ],
        ),
        bottomNavigationBar:
            BottomConvexBar(onChanged: (int i) => setState(() => current = i)));
  }
}
