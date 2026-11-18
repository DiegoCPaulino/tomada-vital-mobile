import 'package:flutter/material.dart';

import '../models/enums.dart';

/// Every color used by the app lives here, so all screens share one palette.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1446A0);
  static const Color primaryLight = Color(0xFFE6ECF7);
  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1B1F2A);
  static const Color textSecondary = Color(0xFF4A5468);
  static const Color border = Color(0xFF8C97AD);
  static const Color divider = Color(0xFFE4E8F0);

  static const Color success = Color(0xFF1E7A3C);
  static const Color successLight = Color(0xFFE3F1E7);
  static const Color critical = Color(0xFFB3261E);
  static const Color criticalLight = Color(0xFFFBE9E7);
  static const Color high = Color(0xFFB25E00);
  static const Color moderate = Color(0xFF7A6A00);

  /// Color that represents each priority level on badges and cards.
  static Color forPriority(Priority priority) {
    return switch (priority) {
      Priority.critical => critical,
      Priority.high => high,
      Priority.moderate => moderate,
    };
  }
}
