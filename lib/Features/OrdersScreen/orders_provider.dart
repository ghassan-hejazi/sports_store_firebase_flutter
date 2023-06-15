import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersProvider extends ChangeNotifier {
  final addToOrdersCollection = FirebaseFirestore.instance
      .collection('addToOrders')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("items")
      .snapshots();
}
