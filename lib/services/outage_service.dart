import '../models/enums.dart';
import '../models/equipment.dart';
import '../models/outage.dart';
import '../models/response_step.dart';
import '../repositories/equipment_repository.dart';
import '../repositories/outage_repository.dart';
import 'priority_service.dart';

/// Business actions on outages: register a new one, let time pass and
/// close it when the power comes back. The Home screen only calls these.
class OutageService {
  OutageService({OutageRepository? outages, EquipmentRepository? equipments})
      : _outages = outages ?? OutageRepository.instance,
        _equipments = equipments ?? EquipmentRepository.instance;

  final OutageRepository _outages;
  final EquipmentRepository _equipments;

  /// Battery level used when the family simulates an outage in the app.
  static const int simulatedBatteryPercent = 20;

  /// The most urgent active outage among the devices of a patient.
  Outage? activeOutageOfPatient(int patientId) {
    final deviceIds = _equipments.findByPatient(patientId).map((equipment) => equipment.id).toSet();
    for (final outage in _outages.activeQueue()) {
      if (deviceIds.contains(outage.equipmentId)) {
        return outage;
      }
    }
    return null;
  }

  Outage registerOutage(Equipment equipment, int batteryPercent) {
    final remaining = PriorityService.calculateRemainingMinutes(
      batteryLifeMinutes: equipment.batteryLifeMinutes,
      batteryPercent: batteryPercent,
    );
    final outage = Outage(
      id: _outages.nextOutageId(),
      equipmentId: equipment.id,
      startedAt: DateTime.now(),
      batteryPercent: batteryPercent,
      remainingMinutes: remaining,
      priority: PriorityService.classify(
        batteryLifeMinutes: equipment.batteryLifeMinutes,
        remainingMinutes: remaining,
      ),
      status: OutageStatus.open,
    );
    _outages.save(outage);
    return outage;
  }

  /// Takes [minutes] off the battery and recalculates the priority.
  Outage advanceTime(Outage outage, int minutes) {
    final equipment = _equipments.findById(outage.equipmentId);
    final remaining = outage.remainingMinutes - minutes < 0 ? 0 : outage.remainingMinutes - minutes;
    final updated = outage.copyWith(
      remainingMinutes: remaining,
      priority: PriorityService.classify(
        batteryLifeMinutes: equipment?.batteryLifeMinutes ?? 0,
        remainingMinutes: remaining,
      ),
    );
    _outages.save(updated);
    return updated;
  }

  Outage restorePower(Outage outage) {
    final now = DateTime.now();
    final resolved = outage.copyWith(status: OutageStatus.resolved, endedAt: now);
    _outages.save(resolved);
    _outages.addStep(ResponseStep(
      id: _outages.nextStepId(),
      outageId: outage.id,
      performedAt: now,
      action: ResponseAction.powerRestored,
      note: 'Rede religada pela concessionária',
    ));
    return resolved;
  }

  int? queuePositionOf(Outage outage) => _outages.queuePositionOf(outage);
}
