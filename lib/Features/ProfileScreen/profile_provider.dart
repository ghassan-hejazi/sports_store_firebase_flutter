import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final usersCollection = FirebaseFirestore.instance
      .collection('Users')
      .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}
