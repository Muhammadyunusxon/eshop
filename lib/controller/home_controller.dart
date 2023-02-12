import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domen/model/category_model.dart';
import '../domen/model/product_model.dart';

class HomeController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<ProductModel> listOfProduct = [];
  List<ProductModel> listOfFavouriteProduct = [];
  List<CategoryModel> listOfCategory = [];
  bool setFilter = false;
  bool isProductLoading = true;
  bool isLoading = false;
  int selectIndex = -1;
  RangeValues currentRangeValues = const RangeValues(0, 5000);

  getProduct({bool isLimit = true}) async {
    isProductLoading = true;
    notifyListeners();
    QuerySnapshot<Map<String, dynamic>> res;
    if (isLimit) {
      res = await firestore.collection("products").limit(10).get();
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

  changeIndex(int index) async {
    if (selectIndex == index) {
      selectIndex = -1;
      getProduct(isLimit: false);
      setFilter = false;
    } else {
      setFilter = true;
      selectIndex = index;
      var res = await firestore
          .collection("products")
          .where("category", isEqualTo: listOfCategory[selectIndex].id)
          .get();
      listOfProduct.clear();
      for (var element in res.docs) {
        listOfProduct
            .add(ProductModel.fromJson(data: element.data(), id: element.id));
      }
    }

    notifyListeners();
    getFavourites();
  }

  changeCurrent(RangeValues value) async {
    isProductLoading=true;
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
    isProductLoading=false;
    notifyListeners();
    getFavourites();

  }

  searchProduct(String name) async {
    isProductLoading=true;
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
    isProductLoading=false;
    notifyListeners();
    getFavourites();
  }

}
