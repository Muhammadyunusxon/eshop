import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../domen/model/product_model.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _image = ImagePicker();

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
  bool addError = false;

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

  setCategory(String category) {
    selectCategoryIndex = listOfCategory.indexOf(category);
  }

  createProduct(
      {required String name,
      required String desc,
      required String price}) async {
    isSaveLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("productImage/${DateTime.now().toString()}");
    await storageRef.putFile(File(imagePath));
    String url = await storageRef.getDownloadURL();

    await firestore.collection("products").add(ProductModel(
            name: name,
            desc: desc,
            image: url,
            price: double.tryParse(price) ?? 0,
            category: res?.docs[selectCategoryIndex].id,
            isLike: false,
            id: "")
        .toJson());
    isSaveLoading = false;
    notifyListeners();
  }

  Future<Uint8List?> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 800,
      minHeight: 800,
      quality: 70,
      rotate: 60,
    );
    return result;
  }

  getImageCamera() {
    _image.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getImageGallery() {
    _image.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        testCompressFile(File(imagePath));
        notifyListeners();
      }
    });
    notifyListeners();
  }

  clearImage() {
    imagePath = '';
    notifyListeners();
  }



}
