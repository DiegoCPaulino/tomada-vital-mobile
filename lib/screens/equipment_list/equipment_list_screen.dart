import 'package:flutter/material.dart';

import '../../models/equipment.dart';
import '../../models/patient.dart';
import '../../repositories/equipment_repository.dart';
import '../../repositories/outage_repository.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/app_header.dart';
import '../../widgets/equipment_card.dart';
import '../equipment_detail/equipment_detail_screen.dart';
import '../equipment_form/equipment_form_screen.dart';

/// Devices of the [patient]. The list is read again on every build,
/// so a device registered in the form shows up when the user comes back.
class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key, required this.patient});

  final Patient patient;

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  Future<void> _openForm() async {
    final created = await Navigator.push<Equipment>(
      context,
      MaterialPageRoute(builder: (_) => EquipmentFormScreen(patient: widget.patient)),
    );
    if (created != null && mounted) {
      setState(() {});
    }
  }

  void _openDetail(Equipment equipment) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EquipmentDetailScreen(equipment: equipment)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final equipments = EquipmentRepository.instance.findByPatient(widget.patient.id);
    final count = equipments.length;

    return Scaffold(
      appBar: const AppHeader(title: 'Meus equipamentos'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Cadastrar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Text(
              '$count ${count == 1 ? 'aparelho' : 'aparelhos'} de ${widget.patient.name}',
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            child: equipments.isEmpty
                ? const Center(child: Text('Nenhum equipamento cadastrado'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 96),
                    itemCount: equipments.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final equipment = equipments[index];
                      return EquipmentCard(
                        equipment: equipment,
                        hasActiveOutage: OutageRepository.instance.findActiveByEquipment(equipment.id) != null,
                        onTap: () => _openDetail(equipment),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
