// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.labelText,
    required this.validatorString,
    required this.keyboardType,
    this.suffixIcon,
    required this.obscureText,
    required this.maxLines,
  });
  final TextEditingController controller;
  IconData icon;
  String labelText;
  String validatorString;
  TextInputType keyboardType;
  Widget? suffixIcon;
  bool obscureText;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: 1,
      style: TextStyle(
        fontSize: FontSizes.sp18,
        decorationThickness: AppSizes.r0,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppSizes.r16,
          horizontal: AppSizes.r0,
        ),
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
          icon,
          size: AppSizes.r25,
          color: AppColors.blue,
        ),
        suffixIcon: suffixIcon,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validatorString;
        }
        return null;
      },
    );
  }
}
