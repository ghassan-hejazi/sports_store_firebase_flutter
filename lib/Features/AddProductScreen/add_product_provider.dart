// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_store/Core/widget/showd_loading.dart';
import 'package:sports_store/Features/HomeAdminScreen/home_admin_screen.dart';

class AddProductProvider extends ChangeNotifier {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController description = TextEditingController();

  int activeIndex = 0;
  activeInde(int index) {
    activeIndex = index;
    notifyListeners();
  }

  final productCollection = FirebaseFirestore.instance.collection('Product');
  List<String> items = [];
  void writeData(context) {
    showdLoading(context);
    productCollection.doc().set(
      {
        'title': title.text,
        'price': price.text,
        'brand': brand.text,
        'description': description.text,
        'imageurl': downloadURLs,
        'size': items,
      },
    ).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeAdminScreen()),
          (route) => false);
    }).catchError((error) {
      print('Failed to insert data: $error');
    });

    notifyListeners();
  }

  late File file;
  late Reference ref;
  dynamic imageurl;
  List<String> downloadURLs = [];
  addImage(context) async {
    List<XFile>? imageFiles = await ImagePicker().pickMultiImage();
    showdLoading(context);
    for (XFile imageFile in imageFiles) {
      file = File(imageFile.path);
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      ref = FirebaseStorage.instance.ref("images").child(imageName);
      await ref.putFile(file);
      imageurl = await ref.getDownloadURL();
      downloadURLs.add(imageurl);
      notifyListeners();
    }
    Navigator.pop(context);
  }

  // addImage(context) async {
//   var picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (picked != null) {
//     showLoadingDialog(context);
//     file = File(picked.path);
//     var rand = Random().nextInt(100000);
//     var nameimage = "$rand${picked.path}";
//     ref = FirebaseStorage.instance.ref("images").child(nameimage);
//     await ref.putFile(file);
//     imageurl = await ref.getDownloadURL();
//     Navigator.pop(context);
//     notifyListeners();
//   }
// }
}
