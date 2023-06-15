import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final productCollection = FirebaseFirestore.instance.collection('Product');

  final addToOrdersCollection =
      FirebaseFirestore.instance.collection('addToOrders');
  final addToOrdersAdminCollection =
      FirebaseFirestore.instance.collection('addToOrdersAdmin');
  String formatter = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());

  List<dynamic> sizes = [];
  addToOrders(
    String title,
    String price,
    String brand,
    String imageurl,
    int number,
    List<dynamic> sized,
  ) async {
    await addToOrdersCollection
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set({
      'title': title,
      'price': price,
      'brand': brand,
      'imageurl': imageurl,
      'number': number,
      'size': sized,
      'date': formatter,
    });
  }

  addToOrdersAdmin(
    String title,
    String price,
    String brand,
    String imageurl,
    int number,
    List<dynamic> sized,
  ) async {
    await addToOrdersAdminCollection.doc().set({
      'title': title,
      'price': price,
      'brand': brand,
      'imageurl': imageurl,
      'number': number,
      'size': sized,
      'date': formatter,
    });
  }

  int currentCount = 1;
  removeCurrentCount() {
    if (currentCount > 1) {
      currentCount--;
    }
    notifyListeners();
  }

  addCurrentCount() {
    currentCount++;
    notifyListeners();
  }

  int activeIndex = 0;
  activeInde(int index) {
    activeIndex = index;
    notifyListeners();
  }

  listSize(List<dynamic> size) {
    sizes = size;
    notifyListeners();
  }
}
