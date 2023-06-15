import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/widget/showd_loading.dart';
import 'package:sports_store/Features/HomeUserScreen/home_user_provider.dart';
import 'package:sports_store/Features/ProductDetailsScreen/product_details__screen.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class SizedBoxListViewWidget extends StatelessWidget {
  const SizedBoxListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeUserProvider>(
      builder: (context, homeUser, _) {
        return SizedBox(
          height: AppSizes.r600,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: homeUser.productCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      listOfSearch = docs.where((e) {
                    if (homeUser.search1.isNotEmpty) {
                      return ((e.data()['title']) as String)
                          .toLowerCase()
                          .startsWith(homeUser.search1.toLowerCase());
                    }
                    return true;
                  }).toList();
                  return ListView.builder(
                    itemCount: listOfSearch.length,
                    itemBuilder: (context, index) {
                      final data = listOfSearch[index].data();
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
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blue,
                                                  ),
                                                  TextWidget(
                                                    text: data['price'],
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
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("AddToCart")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("items")
                                          .doc(snapshot.data!.docs[index].id)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.data == null) {
                                          return const Text("");
                                        }
                                        return Container(
                                          width: AppSizes.r40,
                                          height: AppSizes.r40,
                                          decoration: BoxDecoration(
                                            color: snapshot.data!.data() == null
                                                ? AppColors.grey300
                                                : AppColors.red,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              snapshot.data!.data() == null
                                                  ? await homeUser.addToCart(
                                                      snapshot.data!.id,
                                                      data['title'],
                                                      data['price'],
                                                      data['brand'],
                                                      data['imageurl'][0],
                                                    )
                                                  : showAddToCart(context);
                                            },
                                            icon: Icon(
                                              Icons.add_shopping_cart,
                                              size: AppSizes.r20,
                                            ),
                                          ),
                                        );
                                      }),
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
              }),
        );
      },
    );
  }
}
