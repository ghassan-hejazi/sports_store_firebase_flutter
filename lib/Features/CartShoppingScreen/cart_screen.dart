// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/CartShoppingScreen/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sports_store/Features/ProductDetailsScreen/product_details__screen.dart';

class CartShoppingScreen extends StatelessWidget {
  const CartShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.blueAccent,
        elevation: AppSizes.r0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: AppSizes.r25,
          ),
        ),
        title: TextWidget(
          text: 'Your Cart',
          fontSize: FontSizes.sp18,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
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
        actions: [
          IconButton(
            onPressed: () {},
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
      ),
      body: Consumer<CartProvider>(builder: (context, cart, _) {
        return StreamBuilder<QuerySnapshot>(
            stream: cart.addToCartCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                return Padding(
                    padding: EdgeInsets.all(AppSizes.r16),
                    child: ListView.builder(
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
                                    snapshot.data!.docs[index].id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: AppSizes.r4),
                            child: SizedBox(
                              height: AppSizes.r150,
                              child: Card(
                                elevation: AppSizes.r2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.black12,
                                    width: AppSizes.r1,
                                  ),
                                ),
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
                                            data['imageurl'],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(AppSizes.r10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  text: data['title'],
                                                  fontSize: FontSizes.sp16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                TextWidget(
                                                  text: data['brand']
                                                      .toString()
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.blue,
                                                    ),
                                                    TextWidget(
                                                      text: data['price'],
                                                      fontSize: FontSizes.sp18,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                      width: AppSizes.r40,
                                      height: AppSizes.r40,
                                      decoration: BoxDecoration(
                                        color: AppColors.red,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("AddToCart")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.email)
                                              .collection("items")
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete()
                                              .then((value) =>
                                                  print("User Deleted"))
                                              .catchError((error) => print(
                                                  "Failed to delete user: $error"));
                                        },
                                        icon: Icon(
                                          Icons.add_shopping_cart,
                                          size: AppSizes.r20,
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
                    ));
              }
              return const Center(child: CircularProgressIndicator());
            });
      }),
    );
  }
}
