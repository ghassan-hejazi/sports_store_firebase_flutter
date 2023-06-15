// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  Function() onPressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r40),
        ),
        backgroundColor: AppColors.blueAccent,
        minimumSize: Size(double.infinity, AppSizes.r50),
      ),
      child: TextWidget(
        text: text,
        color: AppColors.white,
        fontSize: FontSizes.sp18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
