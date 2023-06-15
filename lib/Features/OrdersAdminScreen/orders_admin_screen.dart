import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';
import 'package:sports_store/Features/OrdersAdminScreen/orders_admin_provider.dart';

class OrdersAdminScreen extends StatelessWidget {
  const OrdersAdminScreen({super.key});

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
          text: 'Orders',
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
      body: Consumer<OrdersAdminProvider>(builder: (context, orders, _) {
        return StreamBuilder(
          stream: orders.addToOrdersCollection,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(AppSizes.r10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.r4),
                    child: SizedBox(
                      height: AppSizes.r150,
                      child: Card(
                        elevation: AppSizes.r2,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.black12,
                              ),
                              child: Image.network(
                                data['imageurl'],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(AppSizes.r10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: data['title'],
                                      fontSize: FontSizes.sp14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                    TextWidget(
                                      text: data['brand']
                                          .toString()
                                          .toUpperCase(),
                                      fontSize: FontSizes.sp14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: '\$',
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blue,
                                        ),
                                        TextWidget(
                                          text:
                                              '${data['number'] * double.parse(data['price'])}',
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: 'Number : ',
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blue,
                                        ),
                                        TextWidget(
                                          text: 'x${data['number']}',
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: 'Size : ',
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blue,
                                        ),
                                        for (var i = 0;
                                            i < data['size'].length;
                                            i++)
                                          TextWidget(
                                            text: '${data['size'][i]} , ',
                                            fontSize: FontSizes.sp14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      ],
                                    ),
                                    TextWidget(
                                      text: data['date'],
                                      fontSize: FontSizes.sp14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      }),
    );
  }
}
