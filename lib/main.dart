import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/widget/image_splash_widget.dart';
import 'package:sports_store/Features/AddProductScreen/add_product_provider.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_provider.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_screen.dart';
import 'package:sports_store/Features/AuthLogin/SignUpScreen/signup_provider.dart';
import 'package:sports_store/Features/EditProfileScreen/edit_profile_provider.dart';
import 'package:sports_store/Features/HomeAdminScreen/home_admin_provider.dart';
import 'package:sports_store/Features/HomeAdminScreen/home_admin_screen.dart';
import 'package:sports_store/Features/HomeUserScreen/home_user_provider.dart';
import 'package:sports_store/Features/HomeUserScreen/home_user_screen.dart';
import 'package:sports_store/Features/OrdersAdminScreen/orders_admin_provider.dart';
import 'package:sports_store/Features/OrdersScreen/orders_provider.dart';
import 'package:sports_store/Features/ProductDetailsScreen/product_details_provider.dart';
import 'package:sports_store/Features/ProfileScreen/profile_provider.dart';
import 'Features/CartShoppingScreen/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => HomeUserProvider()),
        ChangeNotifierProvider(create: (context) => HomeAdminProvider()),
        ChangeNotifierProvider(create: (context) => AddProductProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
        ChangeNotifierProvider(create: (context) => OrdersAdminProvider()),
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 700),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                duration: 2000,
                splashIconSize: 200,
                splash: const ImageSplashWidget(),
                nextScreen: Consumer<SignInProvider>(
                  builder: (context, authProvider, _) {
                    if (authProvider.getHomePage() == true) {
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .where('user_Id',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.first.data()['role'] ==
                                  'user') {
                                return const HomeUserScreen();
                              }

                              return const HomeAdminScreen();
                            }
                            return const Scaffold(
                              body: Center(child: CircularProgressIndicator()),
                            );
                          });
                    } else {
                      return const SignInScreen();
                    }
                  },
                ),
              ),
            );
          }),
    );
  }
}
