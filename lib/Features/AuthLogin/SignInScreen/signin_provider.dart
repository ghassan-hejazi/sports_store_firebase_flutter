import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/showd_loading.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/HomeAdminScreen/home_admin_screen.dart';
import 'package:sports_store/Features/HomeUserScreen/home_user_screen.dart';

class SignInProvider extends ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  bool passwordVisible = true;
  late DateTime currentBackPressTime;

  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    notifyListeners();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
    notifyListeners();
  }

  final auth = FirebaseAuth.instance;
  signIn(context) async {
    if (formKey1.currentState!.validate()) {
      try {
        showdLoading(context);
        UserCredential credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        if (credential.user != null) {
          FirebaseFirestore.instance
              .collection('Users')
              .where('user_Id',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((QuerySnapshot snapshot) {
            Map<String, dynamic> data =
                snapshot.docs.first.data() as Map<String, dynamic>;

            if (data['role'] == 'admin') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeAdminScreen()),
                  (route) => false);
            } else if (data['role'] == 'user') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeUserScreen()),
                  (route) => false);
            }
            notifyListeners();
          });
        }
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop(context);
          AwesomeDialog(
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            context: context,
            padding: EdgeInsets.all(AppSizes.r8),
            title: 'Error',
            body: TextWidget(
              text: 'No user found for that email.',
              fontSize: FontSizes.sp16,
              fontWeight: FontWeight.w500,
            ),
          ).show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop(context);
          AwesomeDialog(
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            context: context,
            padding: EdgeInsets.all(AppSizes.r8),
            title: 'Error',
            body: TextWidget(
              text: 'Wrong password provided for that user.',
              fontSize: FontSizes.sp16,
              fontWeight: FontWeight.w500,
            ),
          ).show();
        }
      }
    }
  }

  getPasswordVisible() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  var presscount = 0;
  willPopScope(context) {
    presscount++;

    if (presscount == 2) {
      exit(0);
    } else {
      var snackBar = const SnackBar(
        content: Text('Press again to exit the application'),
        duration: Duration(
          seconds: 5,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  getHomePage() {
    bool islogin;
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      islogin = false;
    } else {
      islogin = true;
    }
    return islogin;
  }
}
