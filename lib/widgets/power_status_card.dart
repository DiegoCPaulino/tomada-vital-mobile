import 'package:flutter/material.dart';

import '../models/equipment.dart';
import '../models/outage.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../utils/formatters.dart';
import '../utils/labels.dart';

/// Big card on the Home screen: green while the power is on,
/// colored by priority while there is an outage.
class PowerStatusCard extends StatelessWidget {
  const PowerStatusCard({super.key, this.outage, this.equipment, this.queuePosition});

  final Outage? outage;
  final Equipment? equipment;
  final int? queuePosition;

  @override
  Widget build(BuildContext context) {
    final current = outage;
    final background = current == null ? AppColors.success : AppColors.forPriority(current.priority);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(AppSpacing.radius + 2)),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: current == null ? _buildNormal() : _buildOutage(current),
      ),
    );
  }

  Widget _buildNormal() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text('Energia normal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        SizedBox(height: 8),
        Text('Todos os aparelhos estão ligados na tomada.', style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

  Widget _buildOutage(Outage current) {
    final device = equipment;
    final deviceText = device == null ? '' : '${device.deviceCode} · ${device.type.label} · ';
    final position = queuePosition;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.power_off, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Queda de energia detectada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('${deviceText}bateria em ${current.batteryPercent}%', style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${current.remainingMinutes}',
              style: const TextStyle(fontSize: 44, fontWeight: FontWeight.bold, height: 1),
            ),
            const SizedBox(width: 8),
            const Text('min de bateria', style: TextStyle(fontSize: 16)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text(
                current.priority.label,
                style: TextStyle(
                  color: AppColors.forPriority(current.priority),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        if (position != null) ...[
          const SizedBox(height: 8),
          Text(
            'Posição na fila da central: ${Formatters.queuePosition(position)}',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ],
    );
  }
}
