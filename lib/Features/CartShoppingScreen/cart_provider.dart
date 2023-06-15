import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final productCollection = FirebaseFirestore.instance.collection('Product');
  final addToCartCollection = FirebaseFirestore.instance
      .collection('AddToCart')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('items');
}
