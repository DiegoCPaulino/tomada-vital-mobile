import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// A big number with a small caption below it.
class StatValue extends StatelessWidget {
  const StatValue({super.key, required this.value, required this.caption, this.color = AppColors.textPrimary});

  final String value;
  final String caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(caption, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}
