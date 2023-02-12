import 'package:eshop/views/pages/add_product/widgets/image_filed.dart';
import 'package:eshop/views/utils/components/my_button.dart';
import 'package:eshop/views/utils/components/my_form_field.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../controller/product_controller.dart';
import '../../utils/components/my_drop_down.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameTextEditController = TextEditingController();
  final TextEditingController descTextEditController = TextEditingController();
  final TextEditingController priceTextEditController = TextEditingController();
  final TextEditingController newCategoryTextEditController =
      TextEditingController();
  final TextEditingController categoryTextEditController =
      TextEditingController();
  final TextEditingController typeEditController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final event = context.read<ProductController>();
    final state = context.watch<ProductController>();
    return Scaffold(
      backgroundColor: kMediumColor,
      appBar: AppBar(
        backgroundColor: kBrandColor,
        title: const Text("AddProduct"),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const ImageField(),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: nameTextEditController,
                    title: "name",
                    textInputAction: TextInputAction.next,
                  ),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: descTextEditController,
                    title: "desc",
                    textInputAction: TextInputAction.next,
                  ),
                  18.verticalSpace,
                  MyFormFiled(
                    controller: priceTextEditController,
                    title: "price",
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  18.verticalSpace,
                  MyDropDown(
                    list: state.listOfCategory,
                    onChanged: (s) {
                      context
                          .read<ProductController>()
                          .setCategory(s.toString());
                    },
                    hint: 'category',
                  ),
                  32.verticalSpace,
                  MyButton(
                    onTap: () {
                      event.createProduct(
                          name: nameTextEditController.text,
                          desc: descTextEditController.text,
                          price: priceTextEditController.text);
                    },
                    title: 'Save',
                    isLoading: state.isSaveLoading,
                  ),
                  18.verticalSpace,
                ],
              ),
            ),
    );
  }
}
