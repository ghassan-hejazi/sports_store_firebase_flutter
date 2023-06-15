// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeAdminProvider extends ChangeNotifier {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Product');

  var presscount = 0;
  willPopScope(context) {
    presscount++;

    if (presscount == 2) {
      exit(0);
    } else {
      var snackBar = const SnackBar(
        content: Text('willPopScope'),
        duration: Duration(
          seconds: 5,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}
