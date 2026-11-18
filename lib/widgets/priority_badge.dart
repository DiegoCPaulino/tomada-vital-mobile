import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../theme/app_colors.dart';
import '../utils/labels.dart';
import 'status_pill.dart';

/// Shows the priority of an outage with its color.
class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});

  final Priority priority;

  @override
  Widget build(BuildContext context) {
    return StatusPill(text: priority.label, color: AppColors.forPriority(priority));
  }
}
