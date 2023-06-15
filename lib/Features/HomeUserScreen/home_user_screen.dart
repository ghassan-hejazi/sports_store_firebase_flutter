// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_screen.dart';
import 'package:sports_store/Features/CartShoppingScreen/cart_screen.dart';
import 'package:sports_store/Features/HomeUserScreen/home_user_provider.dart';
import 'package:sports_store/Features/HomeUserScreen/Widget/sizedbox_listview_widget.dart';
import 'package:sports_store/Features/OrdersScreen/orders_screen.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/list_tile_widget.dart';
import 'package:sports_store/Features/ProfileScreen/profile_screen.dart';
import 'package:badges/badges.dart' as badges;

class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeUserProvider>(
      builder: (context, homeUser, _) {
        return WillPopScope(
          onWillPop: () => homeUser.onWillPop(),
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.blueAccent,
              elevation: AppSizes.r0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: AppColors.white,
                    size: AppSizes.r28,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartShoppingScreen(),
                      ),
                    );
                  },
                  icon: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('AddToCart')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection('items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text("");
                        }
                        return snapshot.data!.docs.isNotEmpty
                            ? badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  padding: EdgeInsets.all(AppSizes.r6),
                                ),
                                stackFit: StackFit.expand,
                                badgeContent: TextWidget(
                                  text: snapshot.data!.docs.length.toString(),
                                  fontSize: FontSizes.sp16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.white,
                                  size: AppSizes.r25,
                                ),
                              )
                            : Icon(
                                Icons.shopping_cart,
                                color: AppColors.white,
                                size: AppSizes.r25,
                              );
                      }),
                ),
                SizedBox(
                  width: AppSizes.r8,
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, AppSizes.r8),
                child: const SizedBox(),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(AppSizes.r150, AppSizes.r16),
                  bottomRight: Radius.elliptical(AppSizes.r150, AppSizes.r16),
                ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.black12,
                    ),
                    child: Column(children: [
                      CircleAvatar(
                        radius: AppSizes.r40,
                        backgroundColor: AppColors.grey,
                        child: Icon(
                          Icons.person,
                          color: AppColors.black,
                          size: AppSizes.r28,
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.r16,
                      ),
                      Expanded(
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: FontSizes.sp16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                  ),
                  ListTileWidget(
                    text: 'Orders',
                    iconLeading: Icons.shopping_bag,
                    iconTrailing: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrdersScreen(),
                        ),
                      );
                    },
                  ),
                  ListTileWidget(
                    text: 'Profile',
                    iconLeading: Icons.person,
                    iconTrailing: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  ListTileWidget(
                    text: 'Shopping Cart',
                    iconLeading: Icons.shopping_cart,
                    iconTrailing: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartShoppingScreen(),
                        ),
                      );
                    },
                  ),
                  ListTileWidget(
                    text: 'Edit Profile',
                    iconLeading: Icons.edit,
                    iconTrailing: Icons.arrow_forward_ios,
                    onTap: () async {
                      homeUser.getEditProfileScreen(context);
                    },
                  ),
                  SizedBox(
                    height: AppSizes.r28,
                  ),
                  Divider(
                    thickness: AppSizes.r1,
                    height: AppSizes.r0,
                  ),
                  ListTileWidget(
                    text: 'Log Out',
                    iconLeading: Icons.logout,
                    iconTrailing: Icons.power_settings_new,
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()),
                              (route) => false));
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(AppSizes.r16),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        homeUser.getsearch(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search here...',
                        contentPadding: EdgeInsets.all(AppSizes.r8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r40),
                          borderSide: BorderSide(color: AppColors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r40),
                          borderSide: BorderSide(color: AppColors.blue),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r40),
                          borderSide: BorderSide(color: AppColors.blue),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.r40),
                          borderSide: BorderSide(color: AppColors.blue),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: AppSizes.r25,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.r20),
                    const SizedBoxListViewWidget()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
