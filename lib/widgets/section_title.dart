import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Small grey title that opens a section of a screen.
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    );
  }
}
