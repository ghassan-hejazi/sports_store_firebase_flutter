// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Features/AddProductScreen/add_product_screen.dart';
import 'package:sports_store/Features/AuthLogin/SignInScreen/signin_screen.dart';
import 'package:sports_store/Features/HomeAdminScreen/home_admin_provider.dart';
import 'package:sports_store/Features/OrdersAdminScreen/orders_admin_screen.dart';
import 'package:sports_store/Features/ProductDetailsScreen/product_details__screen.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/list_tile_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeAdminProvider>(
      builder: (context, homeAdmin, _) {
        return WillPopScope(
          onWillPop: () => homeAdmin.willPopScope(context),
          child: Scaffold(
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
                            builder: (context) => const OrdersAdminScreen()),
                      );
                    },
                  ),
                  ListTileWidget(
                    text: 'Add Product',
                    iconLeading: Icons.add_box,
                    iconTrailing: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddProductScreen()),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.r28),
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
            body: StreamBuilder<QuerySnapshot>(
              stream: homeAdmin.productCollection.snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.r4),
                          child: SizedBox(
                            height: AppSizes.r150,
                            child: Card(
                              elevation: AppSizes.r2,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: AppSizes.r150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.r4),
                                          color: AppColors.black12,
                                        ),
                                        child: Image.network(
                                          data['imageurl'][0],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(AppSizes.r10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextWidget(
                                                text: '${data['title']}',
                                                fontSize: FontSizes.sp16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              TextWidget(
                                                text: '${data['brand']}'
                                                    .toUpperCase(),
                                                fontSize: FontSizes.sp14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.grey,
                                              ),
                                              Row(
                                                children: [
                                                  TextWidget(
                                                    text: '\$',
                                                    fontSize: FontSizes.sp18,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blue,
                                                  ),
                                                  TextWidget(
                                                    text: '${data['price']}',
                                                    fontSize: FontSizes.sp18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: AppSizes.r50,
                                    height: AppSizes.r50,
                                    decoration: BoxDecoration(
                                      color: AppColors.black12,
                                      borderRadius:
                                          BorderRadius.circular(AppSizes.r4),
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        await homeAdmin.productCollection
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete()
                                            .then((value) =>
                                                print("User Deleted"))
                                            .catchError((error) => print(
                                                "Failed to delete user: $error"));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: AppSizes.r25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
  }
}
