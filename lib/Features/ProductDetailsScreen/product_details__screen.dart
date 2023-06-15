// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_store/Core/widget/showd_loading.dart';
import 'package:sports_store/Features/ProductDetailsScreen/product_details_provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/elevated_button_widget.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  String docId;
  ProductDetailsScreen(this.docId, {super.key});

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
          text: 'Product Details',
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
      ),
      body: Consumer<ProductDetailsProvider>(
          builder: (context, productDetails, _) {
        return StreamBuilder<DocumentSnapshot>(
            stream: productDetails.productCollection.doc(docId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.r16,
                    vertical: AppSizes.r8,
                  ),
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: AppSizes.r300,
                          decoration: BoxDecoration(
                            color: AppColors.black12,
                            borderRadius: BorderRadius.circular(AppSizes.r16),
                          ),
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                  itemCount: data['imageurl'].length,
                                  options: CarouselOptions(
                                      height: AppSizes.r250,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      onPageChanged: (index, reason) {
                                        productDetails.activeInde(index);
                                      }),
                                  itemBuilder: (BuildContext context, int index,
                                      int pageViewIndex) {
                                    return Image.network(
                                      data['imageurl'][index],
                                    );
                                  }),
                              SizedBox(height: AppSizes.r25),
                              Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: productDetails.activeIndex,
                                  count: data['imageurl'].length,
                                  effect: WormEffect(
                                    dotWidth: AppSizes.r10,
                                    dotHeight: AppSizes.r10,
                                    spacing: AppSizes.r4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSizes.r16),
                        TextWidget(
                          text: data['title'],
                          fontSize: FontSizes.sp18,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: AppSizes.r8),
                        TextWidget(
                          text: data['brand'].toString().toUpperCase(),
                          fontSize: FontSizes.sp16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                        SizedBox(height: AppSizes.r8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: '\$',
                              fontSize: FontSizes.sp18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blue,
                            ),
                            TextWidget(
                              text:
                                  '${productDetails.currentCount * double.parse(data['price'])}',
                              fontSize: FontSizes.sp18,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.r16),
                    TextWidget(
                      text: 'Size : ',
                      fontSize: FontSizes.sp18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    ),
                    CustomCheckBoxGroup(
                      checkBoxButtonValues: (p0) {
                        productDetails.listSize(p0);
                      },
                      absoluteZeroSpacing: false,
                      height: AppSizes.r40,
                      unSelectedColor: AppColors.white,
                      buttonLables: [
                        for (var i = 0; i < data['size'].length; i++)
                          data['size'][i],
                      ],
                      buttonValuesList: [
                        for (var i = 0; i < data['size'].length; i++)
                          data['size'][i],
                      ],
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: AppColors.white,
                        unSelectedColor: AppColors.black,
                        textStyle: TextStyle(fontSize: FontSizes.sp14),
                      ),
                      selectedColor: AppColors.blueAccent,
                      elevation: AppSizes.r2,
                    ),
                    SizedBox(height: AppSizes.r25),
                    Row(
                      children: [
                        TextWidget(
                          text: 'Qty : ',
                          fontSize: FontSizes.sp18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: AppSizes.r40,
                              decoration: BoxDecoration(
                                color: AppColors.grey300,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.r25),
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        productDetails.removeCurrentCount(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      elevation: AppSizes.r1,
                                      minimumSize:
                                          Size(AppSizes.r40, AppSizes.r40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.r25),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.black,
                                      size: AppSizes.r25,
                                    ),
                                  ),
                                  SizedBox(width: AppSizes.r16),
                                  TextWidget(
                                    text: '${productDetails.currentCount}',
                                    color: AppColors.black,
                                    fontSize: FontSizes.sp18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: AppSizes.r16),
                                  ElevatedButton(
                                    onPressed: () =>
                                        productDetails.addCurrentCount(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      elevation: AppSizes.r1,
                                      minimumSize:
                                          Size(AppSizes.r40, AppSizes.r40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.r25),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.black,
                                      size: AppSizes.r25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.r16),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.all(AppSizes.r0),
                        childrenPadding: EdgeInsets.only(left: AppSizes.r8),
                        backgroundColor: AppColors.white,
                        title: TextWidget(
                          text: 'Description',
                          color: AppColors.blue,
                          fontSize: FontSizes.sp18,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextWidget(
                            text: data['description'],
                            color: AppColors.black,
                            fontSize: FontSizes.sp14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSizes.r16),
                    ElevatedButtonWidget(
                      text: 'BUY NOW',
                      onPressed: () async {
                        if (productDetails.sizes.isNotEmpty) {
                          await showAddToOrders(
                            context,
                            onSuccess: () async {
                              await productDetails.addToOrders(
                                data['title'],
                                data['price'],
                                data['brand'],
                                data['imageurl'][0],
                                productDetails.currentCount,
                                productDetails.sizes,
                              );
                              await productDetails.addToOrdersAdmin(
                                data['title'],
                                data['price'],
                                data['brand'],
                                data['imageurl'][0],
                                productDetails.currentCount,
                                productDetails.sizes,
                              );
                              showAddToPurchase(context);
                            },
                            name: data['title'],
                            price: data['price'],
                            description: data['description'],
                            quantity: productDetails.currentCount.toString(),
                            total: (productDetails.currentCount *
                                    double.parse(data['price']))
                                .toString(),
                          );
                        } else {
                          showErrorSize(context);
                        }
                      },
                      /* onPressed: () async {
                        if (productDetails.sizes.isNotEmpty) {
                          await productDetails.addToOrders(
                            data['title'],
                            data['price'],
                            data['brand'],
                            data['imageurl'][0],
                            productDetails.currentCount,
                            productDetails.sizes,
                          );
                          await productDetails.addToOrdersAdmin(
                            data['title'],
                            data['price'],
                            data['brand'],
                            data['imageurl'][0],
                            productDetails.currentCount,
                            productDetails.sizes,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrdersScreen(),
                              ));
                          showdAddToOrders(context);
                        } else {
                          showdSize(context);
                        }
                      },*/
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            });
      }),
    );
  }
}
