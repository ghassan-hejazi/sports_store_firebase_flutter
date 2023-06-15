import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sports_store/Features/ProfileScreen/profile_screen.dart';

class EditProfileProvider extends ChangeNotifier {
  final users = FirebaseFirestore.instance.collection("Users");
  editProfileData(
    context,
    String userId,
    String name,
    String mobilenumber,
    String country,
    String city,
    String streetandregion,
  ) {
    users.doc(userId).update({
      "username": name,
      "mobilenumber": mobilenumber,
      "country": country,
      "city": city,
      "streetandregion": streetandregion,
    }).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    });
  }
}
