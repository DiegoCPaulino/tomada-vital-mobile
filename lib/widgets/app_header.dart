import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The blue top bar used by every screen.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, required this.title, this.actions, this.showBackButton = true});

  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
    );
  }
}
