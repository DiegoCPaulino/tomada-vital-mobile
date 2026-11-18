import 'package:flutter/material.dart';

import '../models/equipment.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';
import '../utils/labels.dart';
import 'app_card.dart';
import 'equipment_icon.dart';
import 'status_pill.dart';

/// One device in the list, with its current power status.
class EquipmentCard extends StatelessWidget {
  const EquipmentCard({
    super.key,
    required this.equipment,
    required this.hasActiveOutage,
    required this.onTap,
  });

  final Equipment equipment;
  final bool hasActiveOutage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = hasActiveOutage ? AppColors.critical : AppColors.success;
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: hasActiveOutage ? AppColors.criticalLight : AppColors.successLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: EquipmentIcon(type: equipment.type, color: statusColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(equipment.deviceCode, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(equipment.type.label, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 2),
                Text(
                  'Autonomia: ${Formatters.batteryLife(equipment.batteryLifeMinutes)}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          StatusPill(text: hasActiveOutage ? 'SEM ENERGIA' : 'NORMAL', color: statusColor),
        ],
      ),
    );
  }
}
