import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sports_store/Features/EditProfileScreen/edit_profile_screen.dart';

class HomeUserProvider extends ChangeNotifier {
  String search1 = '';
  getsearch(String value) {
    search1 = value;
    notifyListeners();
  }

  final productCollection = FirebaseFirestore.instance.collection('Product');
  final addToCartCollection =
      FirebaseFirestore.instance.collection('AddToCart');
  addToCart(String docId, String title, String price, String brand,
      String imageurl) async {
    await addToCartCollection
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(docId)
        .set({
      'title': title,
      'price': price,
      'brand': brand,
      'imageurl': imageurl,
    });
  }

  late DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    final now = DateTime.now().difference(currentBackPressTime);
    currentBackPressTime = DateTime.now();

    if (now > const Duration(seconds: 2)) {
      Fluttertoast.showToast(msg: 'exit_warning', fontSize: 18);
      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }

  getEditProfileScreen(context) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((QuerySnapshot value) {
      Map<String, dynamic> data =
          value.docs.first.data() as Map<String, dynamic>;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            userId: value.docs.first.id,
            data: data,
          ),
        ),
      );
    });
    notifyListeners();
  }
}
