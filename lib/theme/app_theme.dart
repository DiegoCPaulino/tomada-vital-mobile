import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The single theme of the app, applied in [MaterialApp].
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        error: AppColors.critical,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
