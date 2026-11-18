import 'enums.dart';

/// A power outage detected by the sensor of one device.
class Outage {
  final int id;
  final int equipmentId;
  final DateTime startedAt;
  final DateTime? endedAt;

  /// Battery level (0 to 100) reported when the outage was detected.
  final int batteryPercent;
  final int remainingMinutes;
  final Priority priority;
  final OutageStatus status;

  const Outage({
    required this.id,
    required this.equipmentId,
    required this.startedAt,
    this.endedAt,
    required this.batteryPercent,
    required this.remainingMinutes,
    required this.priority,
    required this.status,
  });

  /// An outage is active until the power comes back.
  bool get isActive => status != OutageStatus.resolved;

  Outage copyWith({
    DateTime? endedAt,
    int? remainingMinutes,
    Priority? priority,
    OutageStatus? status,
  }) {
    return Outage(
      id: id,
      equipmentId: equipmentId,
      startedAt: startedAt,
      endedAt: endedAt ?? this.endedAt,
      batteryPercent: batteryPercent,
      remainingMinutes: remainingMinutes ?? this.remainingMinutes,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}
