import 'package:flutter/material.dart';

import '../models/enums.dart';

/// Icon that represents each kind of device.
class EquipmentIcon extends StatelessWidget {
  const EquipmentIcon({super.key, required this.type, required this.color, this.size = 26});

  final EquipmentType type;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final icon = switch (type) {
      EquipmentType.oxygenConcentrator => Icons.air,
      EquipmentType.ventilator => Icons.masks,
      EquipmentType.suctionDevice => Icons.water_drop,
      EquipmentType.infusionPump => Icons.vaccines,
      EquipmentType.other => Icons.devices_other,
    };
    return Icon(icon, color: color, size: size);
  }
}
