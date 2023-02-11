import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> listOfCategory = [];

  bool isLoading = true;
  bool isSaveLoading = false;
  bool isSaveCategoryLoading = false;
  String docId = '';
  String imagePath = "";
  String categoryImagePath = "";
  QuerySnapshot? res;
  int selectCategoryIndex = 0;
  int selectTypeIndex = 0;
  bool addError=false;

  getCategory() async {
    isLoading = true;
    notifyListeners();
    res = await firestore.collection("category").get();
    listOfCategory.clear();
    if (res != null) {
      for (var element in res!.docs) {
        listOfCategory.add(element["name"]);
      }
    }
    isLoading = false;
    notifyListeners();
  }



}
