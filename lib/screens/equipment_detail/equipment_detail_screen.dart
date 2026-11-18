import 'package:flutter/material.dart';

import '../../models/equipment.dart';
import '../../models/outage.dart';
import '../../repositories/outage_repository.dart';
import '../../repositories/patient_repository.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/formatters.dart';
import '../../utils/labels.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/equipment_icon.dart';
import '../../widgets/info_row.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/priority_badge.dart';
import '../../widgets/stat_value.dart';
import '../response_timeline/response_timeline_screen.dart';

/// Details of one device. Receives the [equipment] from the list.
class EquipmentDetailScreen extends StatelessWidget {
  const EquipmentDetailScreen({super.key, required this.equipment});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    final patient = PatientRepository.instance.findById(equipment.patientId);
    final outage = OutageRepository.instance.findActiveByEquipment(equipment.id);

    return Scaffold(
      appBar: AppHeader(title: equipment.deviceCode),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: EquipmentIcon(type: equipment.type, color: AppColors.primary, size: 34),
                ),
                const SizedBox(height: 10),
                Text(equipment.type.label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  'Código do dispositivo: ${equipment.deviceCode}',
                  style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
            child: Column(
              children: [
                InfoRow(label: 'Paciente', value: patient?.name ?? '-'),
                const Divider(height: 1, color: AppColors.divider),
                InfoRow(label: 'Autonomia da bateria', value: Formatters.batteryLife(equipment.batteryLifeMinutes)),
                const Divider(height: 1, color: AppColors.divider),
                InfoRow(label: 'Endereço', value: patient == null ? '-' : '${patient.neighborhood}, ${patient.city}'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          outage == null ? _buildNoOutage() : _buildOutage(context, outage),
        ],
      ),
    );
  }

  Widget _buildNoOutage() {
    return const AppCard(
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.success),
          SizedBox(width: 10),
          Text('Energia normal neste aparelho', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildOutage(BuildContext context, Outage outage) {
    final position = OutageRepository.instance.queuePositionOf(outage);
    final priorityColor = AppColors.forPriority(outage.priority);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Queda em andamento', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              PriorityBadge(priority: outage.priority),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: StatValue(value: '${outage.batteryPercent}%', caption: 'bateria')),
              Expanded(
                child: StatValue(value: '${outage.remainingMinutes} min', caption: 'restantes', color: priorityColor),
              ),
              Expanded(
                child: StatValue(
                  value: position == null ? '-' : Formatters.queuePosition(position),
                  caption: 'na fila',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Início às ${Formatters.time(outage.startedAt)} · Status: ${outage.status.label.toLowerCase()}',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Ver atendimento',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ResponseTimelineScreen(outage: outage)),
            ),
          ),
        ],
      ),
    );
  }
}
