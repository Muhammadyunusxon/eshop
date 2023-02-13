import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/views/utils/constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../domen/model/category_model.dart';
import '../domen/model/product_model.dart';
import '../views/utils/style.dart';

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  List<ProductModel> listOfProduct = [];
  List<ProductModel> listOfCategoryProduct = [];
  List<ProductModel> listOfFavouriteProduct = [];
  List<CategoryModel> listOfCategory = [];
  bool setFilter = false;
  bool isProductLoading = true;
  bool isCategoryLoading = true;
  bool isLoading = false;

  List<CategoryModel> listOfSelectIndex = [];

  RangeValues currentRangeValues = const RangeValues(0, 5000);

  createDynamicLink(ProductModel productModel) async {
    Fluttertoast.showToast(
        msg: "Ulashilmoqda",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kMediumColor,
        textColor: kTextDarkColor,
        fontSize: 16.0
    );
    var productLink = 'https://demos.uz/${productModel.id}';

    const dynamicLink =
        'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyDWKbyAQGQh9znJuM0hHlUgayw_-wwZjmQ';

    final dataShare = {
      "dynamicLinkInfo": {
        "domainUriPrefix": 'https://eshopuz.page.link',
        "link": productLink,
        "androidInfo": {
          "androidPackageName": 'uz.demos.eshop',
        },
        "iosInfo": {
          "iosBundleId": "uz.demos.eshop",
        },
        "socialMetaTagInfo": {
          "socialTitle":
              (productModel.name?.substring(0, 1).toUpperCase() ?? "") +
                  (productModel.name?.substring(1) ?? ""),
          "socialDescription": "Description: ${productModel.desc}",
          "socialImageLink": "${productModel.image}",
        }
      }
    };

    final res =
        await http.post(Uri.parse(dynamicLink), body: jsonEncode(dataShare));

    var shareLink = jsonDecode(res.body)['shortLink'];
    await FlutterShare.share(
      text: (productModel.name?.substring(0, 1).toUpperCase() ?? "") +
          (productModel.name?.substring(1) ?? ""),
      title: "Description: ${productModel.desc}",
      linkUrl: shareLink,
    );
    Fluttertoast.cancel();
    debugPrint(shareLink);
  }

  initDynamicLinks(ValueChanged onSuccess) async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      debugPrint('dynamic link ${dynamicLinkData.link}');
      String docId = dynamicLinkData.link
          .toString()
          .substring(dynamicLinkData.link.toString().lastIndexOf("/") + 1);
      onSuccess(docId);
    }).onError((error) {
      debugPrint("Dynamic link error${error.message}");
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      String docId = deepLink
          .toString()
          .substring(deepLink.toString().lastIndexOf("/") + 1);
      // ignore: use_build_context_synchronously
      onSuccess(docId);
    }
  }

  getProduct({bool isLimit = true}) async {
    isProductLoading = true;
    notifyListeners();
    QuerySnapshot<Map<String, dynamic>> res;
    if (isLimit) {
      res = await firestore.collection("products").limit(12).get();
    } else {
      res = await firestore.collection("products").get();
    }
    listOfProduct.clear();
    for (var element in res.docs) {
      listOfProduct
          .add(ProductModel.fromJson(data: element.data(), id: element.id));
    }
    isProductLoading = false;
    notifyListeners();
  }

  changeLike({required int index, bool isFav = false}) async {
    if (isFav) {
      listOfFavouriteProduct[index].isLike =
          !listOfFavouriteProduct[index].isLike;
      notifyListeners();
      await firestore
          .collection("products")
          .doc(listOfFavouriteProduct[index].id)
          .update((listOfFavouriteProduct[index]).toJson());
    } else {
      listOfProduct[index].isLike = !listOfProduct[index].isLike;
      notifyListeners();
      await firestore
          .collection("products")
          .doc(listOfProduct[index].id)
          .update((listOfProduct[index]).toJson());
    }
    notifyListeners();
  }

  getFavourites() {
    // ignore: avoid_function_literals_in_foreach_calls
    listOfFavouriteProduct.clear();
    for (var element in listOfProduct) {
      element.isLike == true
          ? listOfFavouriteProduct.add(element)
          : element.isLike = false;
    }
    notifyListeners();
  }

  getCategory() async {
    isLoading = true;
    notifyListeners();
    var res = await firestore.collection("category").get();
    listOfCategory.clear();
    for (var element in res.docs) {
      listOfCategory.add(CategoryModel.fromJson(element.data(), element.id));
    }
    isLoading = false;
    notifyListeners();
  }

  setFilterChange() {
    setFilter = !setFilter;
    notifyListeners();
  }

  changeIndex(CategoryModel model) async {
    if (listOfSelectIndex.contains(model)) {
      listOfSelectIndex.remove(model);
      getProduct(isLimit: false);

    } else {
      setFilter = true;
      listOfSelectIndex.add(model);
      listOfProduct.clear();
      for (int i = 0; i < listOfSelectIndex.length; i++) {
        var res = await firestore
            .collection("products")
            .where("category", isEqualTo: listOfSelectIndex[i].id)
            .get();

        for (var element in res.docs) {
          listOfProduct
              .add(ProductModel.fromJson(data: element.data(), id: element.id));
        }
      }
    }
    if(listOfSelectIndex.isEmpty){
      setFilter = false;
    }

    notifyListeners();
  }

  getOneCategory(CategoryModel model) async {
    isCategoryLoading=true;
    notifyListeners();
    listOfCategoryProduct.clear();
    var res = await firestore
        .collection("products")
        .where("category", isEqualTo: model.id)
        .get();

    for (var element in res.docs) {
      listOfCategoryProduct
          .add(ProductModel.fromJson(data: element.data(), id: element.id));
    }
    isCategoryLoading=false;
    notifyListeners();
  }

  changeCurrent(RangeValues value) async {
    isProductLoading = true;
    currentRangeValues = value;

    notifyListeners();
    var res = await firestore
        .collection("products")
        .where("price", isGreaterThan: value.start, isLessThan: value.end)
        .orderBy("price")
        .get();
    listOfProduct.clear();
    for (var element in res.docs) {
      listOfProduct
          .add((ProductModel.fromJson(data: element.data(), id: element.id)));
    }
    isProductLoading = false;
    notifyListeners();
    getFavourites();
  }

  searchProduct(String name) async {
    isProductLoading = true;
    notifyListeners();
    if (name.isEmpty) {
      getProduct(isLimit: false);
    } else {
      var res = await firestore.collection("products").orderBy("name").startAt(
          [name.toLowerCase()]).endAt(["${name.toLowerCase()}\uf8ff"]).get();
      listOfProduct.clear();
      for (var element in res.docs) {
        listOfProduct
            .add((ProductModel.fromJson(data: element.data(), id: element.id)));
      }
    }
    isProductLoading = false;
    notifyListeners();
  }
}
