import 'package:flutter/material.dart';
import 'package:plumbus/core/theme/app_colors.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
    ),
  );
}
