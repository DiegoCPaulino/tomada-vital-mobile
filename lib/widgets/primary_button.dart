import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// Main button of the app: filled blue, or outlined when [outlined] is true.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.color = AppColors.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const shape = StadiumBorder();
    const textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
    final button = outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: color,
              backgroundColor: AppColors.surface,
              side: BorderSide(color: color, width: 1.5),
              shape: shape,
              textStyle: textStyle,
            ),
            child: Text(label),
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: shape,
              textStyle: textStyle,
            ),
            child: Text(label),
          );
    return SizedBox(height: AppSpacing.buttonHeight, width: double.infinity, child: button);
  }
}
