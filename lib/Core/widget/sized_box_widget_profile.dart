// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';
import 'package:sports_store/Core/widget/text_widget.dart';

class SizedBoxWidgetProfile extends StatelessWidget {
  String text;
  IconData icon;
  SizedBoxWidgetProfile({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.r50,
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.blue,
            size: AppSizes.r28,
          ),
          VerticalDivider(
            width: AppSizes.r16,
            thickness: AppSizes.r1,
          ),
          Expanded(
            child: TextWidget(
              text: text,
              fontSize: FontSizes.sp16,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
