// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

showdLoading(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: TextWidget(
              text: 'Please Wiat',
              fontSize: FontSizes.sp18,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SizedBox(
            height: AppSizes.r55,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      });
}

showErrorSize(context) {
  return AwesomeDialog(
    dialogType: DialogType.error,
    animType: AnimType.topSlide,
    padding: EdgeInsets.all(AppSizes.r8),
    context: context,
    title: 'Error',
    body: TextWidget(
      text: 'Please Choose the Size',
      fontSize: FontSizes.sp16,
      fontWeight: FontWeight.w600,
    ),
  ).show();
}

showAddToCart(context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: AppSizes.r55,
        color: AppColors.black,
        child: Center(
          child: TextWidget(
            text: 'Already Added',
            fontSize: FontSizes.sp16,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ),
      );
    },
  );
}

showAddToOrders(
  context, {
  required String total,
  required String description,
  required String name,
  required String quantity,
  required String price,
  required Function() onSuccess,
}) {
  return showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r50),
          topRight: Radius.circular(AppSizes.r50),
        ),
      ),
      builder: (dialogContex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: AppSizes.r350,
            child: Padding(
              padding: EdgeInsets.all(AppSizes.r20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.blue300,
                        borderRadius: BorderRadius.circular(AppSizes.r20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.r16),
                        child: Image.asset(
                          'assets/images/PayPal.png',
                          height: AppSizes.r64,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckout(
                          sandboxMode: true,
                          clientId:
                              "Acjy9wsRanSOxN_CnfnZmFHztii-JDgjqR_BKgoLKMZUkMJvSFVVWu2jVeo9k9cXAf4u-0ktLOH1frxF",
                          secretKey:
                              "EEzwliW_bscKhc0RNw9dAXflmcdHGDAPu9zhrYv0AlmAQFYDTOqm86kXdF0ebJHNHDPVAtkiKFEkwlB0",
                          returnURL: "success.snippetcoder.com",
                          cancelURL: "cancel.snippetcoder.com",
                          transactions: [
                            {
                              "amount": {
                                "total": total,
                                "currency": "USD",
                                "details": {
                                  "subtotal": total,
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description": description,
                              "item_list": {
                                "items": [
                                  {
                                    "name": name,
                                    "quantity": quantity,
                                    "price": price,
                                    "currency": "USD"
                                  },
                                ],
                                "shipping_address": const {
                                  "recipient_name": "Raman Singh",
                                  "line1": "Delhi",
                                  "line2": "",
                                  "city": "Delhi",
                                  "country_code": "IN",
                                  "postal_code": "11001",
                                  "phone": "+00000000",
                                  "state": "Texas"
                                },
                              }
                            }
                          ],
                          note: "PAYMENT_NOTE",
                          onSuccess: (Map params) async {
                            await onSuccess();
                            print("onSuccess: $params");
                          },
                          onError: (error) {
                            print("onError: $error");
                            Navigator.of(dialogContex).pop();
                          },
                          onCancel: () {
                            print('cancelled:');
                          },
                        ),
                      ));
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.yellowAccent,
                        borderRadius: BorderRadius.circular(AppSizes.r20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.r16),
                        child: Image.asset(
                          'assets/images/MC-Horizontal.png',
                          height: AppSizes.r64,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.blue400,
                        borderRadius: BorderRadius.circular(AppSizes.r20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.r16),
                        child: Image.asset(
                          'assets/images/Visa.png',
                          height: AppSizes.r64,
                        ),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

showAddToPurchase(
  context,
) {
  return AwesomeDialog(
    dialogType: DialogType.success,
    animType: AnimType.topSlide,
    padding: EdgeInsets.all(AppSizes.r8),
    context: context,
    title: 'success',
    body: TextWidget(
      text: 'Purchase Completed Successfully',
      fontSize: FontSizes.sp16,
      fontWeight: FontWeight.w600,
    ),
  ).show();
}
