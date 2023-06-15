import 'package:flutter/material.dart';
import 'package:sports_store/Core/style/app_colors.dart';
import 'package:sports_store/Core/style/app_sizes.dart';

class ImageSplashWidget extends StatelessWidget {
  const ImageSplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: AppSizes.r250,
        ),
      ),
    );
  }
}
