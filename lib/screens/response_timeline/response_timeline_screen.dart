import 'package:flutter/material.dart';

import '../../models/outage.dart';
import '../../repositories/equipment_repository.dart';
import '../../repositories/outage_repository.dart';
import '../../services/timeline_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/formatters.dart';
import '../../utils/labels.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/priority_badge.dart';
import '../../widgets/section_title.dart';
import '../../widgets/timeline_item.dart';
import '../support_points/support_points_screen.dart';

/// Timeline of what the response center did for one outage.
/// Receives the [outage] from the screen that opened it.
class ResponseTimelineScreen extends StatelessWidget {
  const ResponseTimelineScreen({super.key, required this.outage});

  final Outage outage;

  @override
  Widget build(BuildContext context) {
    final equipment = EquipmentRepository.instance.findById(outage.equipmentId);
    final steps = OutageRepository.instance.stepsOf(outage.id);
    final entries = TimelineService.build(outage, steps);
    final position = OutageRepository.instance.queuePositionOf(outage);

    final queueText = position == null ? '' : ' · ${Formatters.queuePosition(position)} na fila da central';
    final summary = outage.isActive
        ? '${outage.remainingMinutes} min de bateria$queueText'
        : 'Energia restabelecida às ${Formatters.time(outage.endedAt ?? outage.startedAt)}';

    return Scaffold(
      appBar: const AppHeader(title: 'Atendimento'),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        equipment == null ? 'Aparelho' : '${equipment.deviceCode} · ${equipment.type.label}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    PriorityBadge(priority: outage.priority),
                  ],
                ),
                const SizedBox(height: 6),
                Text(summary, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          const SectionTitle(text: 'O que a central já fez'),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < entries.length; i++)
            TimelineItem(entry: entries[i], isLast: i == entries.length - 1),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: 'Ver pontos de apoio com gerador',
            outlined: true,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SupportPointsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
