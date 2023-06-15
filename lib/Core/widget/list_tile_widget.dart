// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget({
    required this.text,
    required this.iconLeading,
    required this.iconTrailing,
    required this.onTap,
    super.key,
  });
  String text;
  IconData iconLeading;
  IconData iconTrailing;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(AppSizes.r8),
      horizontalTitleGap: 0,
      title: Text(
        text,
        style: TextStyle(
          fontSize: FontSizes.sp16,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: Icon(
        iconLeading,
        color: AppColors.grey,
        size: AppSizes.r25,
      ),
      trailing: Icon(
        iconTrailing,
        color: AppColors.grey,
        size: AppSizes.r20,
      ),
      onTap: onTap,
    );
  }
}
