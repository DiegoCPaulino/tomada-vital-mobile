import 'enums.dart';

/// A device plugged into a Tomada Vital sensor.
class Equipment {
  final int id;
  final int patientId;
  final EquipmentType type;

  /// Minutes the device runs on a full battery. Zero means it has no battery.
  final int batteryLifeMinutes;

  /// Code printed on the sensor, in the format TV-000.
  final String deviceCode;

  const Equipment({
    required this.id,
    required this.patientId,
    required this.type,
    required this.batteryLifeMinutes,
    required this.deviceCode,
  });

  bool get hasBattery => batteryLifeMinutes > 0;
}
