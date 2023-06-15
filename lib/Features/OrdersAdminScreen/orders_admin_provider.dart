import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersAdminProvider extends ChangeNotifier {
  final addToOrdersCollection =
      FirebaseFirestore.instance.collection('addToOrdersAdmin').snapshots();
}
