import 'package:eshop/controller/home_controller.dart';
import 'package:eshop/views/utils/components/my_app_bar.dart';
import 'package:eshop/views/utils/components/my_product.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class AllProductScreen extends StatefulWidget {
  const AllProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>()
        ..getProduct()
        ..getCategory();
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    return Scaffold(
      backgroundColor: kMediumColor,
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onLoading: () {},
                onRefresh: () async {
                  context.read<HomeController>().getProduct(isRefresh: true);
                  _refreshController.refreshCompleted();
                },
                child: state.isProductLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: kBrandColor,
                      ))
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listOfProduct.length,
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
                            product: state.listOfProduct[index],
                            index: index,
                          );
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
