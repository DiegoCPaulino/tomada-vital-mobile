import 'package:flutter/material.dart';

import '../../models/equipment.dart';
import '../../models/outage.dart';
import '../../models/patient.dart';
import '../../repositories/equipment_repository.dart';
import '../../routes/app_routes.dart';
import '../../services/outage_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/formatters.dart';
import '../../utils/labels.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_header.dart';
import '../../widgets/power_status_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/quick_access_tile.dart';
import '../../widgets/section_title.dart';
import '../equipment_list/equipment_list_screen.dart';
import '../response_timeline/response_timeline_screen.dart';
import '../support_points/support_points_screen.dart';

/// Main screen of the family. Shows the power status of the house and
/// lets the user simulate an outage, let time pass and restore the power.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.patient});

  final Patient patient;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _minutesPerStep = 30;

  final OutageService _outageService = OutageService();
  Outage? _outage;

  List<Equipment> get _equipments => EquipmentRepository.instance.findByPatient(widget.patient.id);

  @override
  void initState() {
    super.initState();
    _outage = _outageService.activeOutageOfPatient(widget.patient.id);
  }

  Equipment? _equipmentOf(Outage outage) => EquipmentRepository.instance.findById(outage.equipmentId);

  void _simulateOutage() {
    final equipments = _equipments;
    if (equipments.isEmpty) {
      return;
    }
    setState(() {
      _outage = _outageService.registerOutage(equipments.first, OutageService.simulatedBatteryPercent);
    });
  }

  void _passTime() {
    final outage = _outage;
    if (outage == null) {
      return;
    }
    setState(() {
      _outage = _outageService.advanceTime(outage, _minutesPerStep);
    });
  }

  void _restorePower() {
    final outage = _outage;
    if (outage == null) {
      return;
    }
    _outageService.restorePower(outage);
    setState(() {
      _outage = null;
    });
    _showMessage('Energia restabelecida. A ocorrência foi encerrada.');
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _openEquipments() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EquipmentListScreen(patient: widget.patient)),
    );
    if (mounted) {
      setState(() {});
    }
  }

  void _openResponse() {
    final outage = _outage;
    if (outage == null) {
      _showMessage('Nenhuma queda de energia em andamento.');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResponseTimelineScreen(outage: outage)),
    );
  }

  void _openSupportPoints() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPointsScreen()));
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final outage = _outage;
    final equipments = _equipments;

    return Scaffold(
      appBar: AppHeader(
        title: 'Minha casa',
        showBackButton: false,
        actions: [
          IconButton(onPressed: _logout, tooltip: 'Sair', icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const Text('Olá, família da', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          Text(widget.patient.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(
            '${widget.patient.neighborhood} · ${widget.patient.city}',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          PowerStatusCard(
            outage: outage,
            equipment: outage == null ? null : _equipmentOf(outage),
            queuePosition: outage == null ? null : _outageService.queuePositionOf(outage),
          ),
          const SizedBox(height: 12),
          if (outage == null)
            PrimaryButton(
              label: 'Simular queda de energia',
              onPressed: equipments.isEmpty ? null : _simulateOutage,
            )
          else
            Row(
              children: [
                Expanded(child: PrimaryButton(label: 'Passar 30 min', outlined: true, onPressed: _passTime)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: PrimaryButton(label: 'Energia voltou', color: AppColors.success, onPressed: _restorePower),
                ),
              ],
            ),
          const SizedBox(height: AppSpacing.lg),
          const SectionTitle(text: 'Acesso rápido'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: QuickAccessTile(icon: Icons.devices, label: 'Equipamentos', onTap: _openEquipments),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: QuickAccessTile(icon: Icons.schedule, label: 'Atendimento', onTap: _openResponse),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: QuickAccessTile(icon: Icons.place, label: 'Pontos de apoio', onTap: _openSupportPoints),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aparelhos monitorados',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final equipment in equipments)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${equipment.deviceCode} · ${equipment.type.label}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          Formatters.batteryLife(equipment.batteryLifeMinutes),
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
