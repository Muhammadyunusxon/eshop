import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/utils/components/my_app_bar.dart';
import 'package:eshop/views/utils/components/my_product.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domen/model/category_model.dart';

class CategoryProducts extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryProducts({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().getOneCategory(widget.categoryModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Scaffold(
      backgroundColor: kMediumColor,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(categoryName:  widget.categoryModel.name ?? ''),
            Expanded(
              child: state.isCategoryLoading
                  ? const Center(
                  child: CircularProgressIndicator(
                    color: kBrandColor,
                  ))
                  : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.listOfCategoryProduct.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 18),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 175,
                      mainAxisSpacing: 16),
                  itemBuilder: (context, index) {
                    return MyProduct(
                      product: state.listOfCategoryProduct[index],
                      index: index,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
