import 'package:flutter/material.dart';
import 'package:plumbus/core/theme/app_colors.dart';
import 'package:plumbus/core/theme/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Image.asset(AppImages.logoFull)),
    );
  }
}
