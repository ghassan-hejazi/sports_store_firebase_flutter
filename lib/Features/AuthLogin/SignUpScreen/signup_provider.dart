// ignore_for_file: avoid_print
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sports_store/Core/widget/showd_loading.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_screen.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController streetAndRegion = TextEditingController();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  bool passwordVisible = true;

  signUp(context) async {
    if (formKey2.currentState!.validate()) {
      try {
        showdLoading(context);
        UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop(context);
          AwesomeDialog(
            context: context,
            title: 'Error',
            body: const Text('The password provided is too weak.'),
          ).show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop(context);
          AwesomeDialog(
            context: context,
            title: 'Error',
            body: const Text('The account already exists for that email.'),
          ).show();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  addData() {
    FirebaseFirestore.instance.collection("Users").add({
      "username": name.text,
      "email": email.text,
      "password": password.text,
      "mobilenumber": mobilenumber.text,
      "country": country.text,
      "city": city.text,
      "streetandregion": streetAndRegion.text,
      "user_Id": FirebaseAuth.instance.currentUser!.uid,
      "role": "user",
    });
  }

  addDataUser(context) async {
    var response = await signUp(context);
    if (response != null) {
      await addData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false);
    }
    notifyListeners();
  }

  getPasswordVisible() {
    passwordVisible = !passwordVisible;
    notifyListeners();
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
}
