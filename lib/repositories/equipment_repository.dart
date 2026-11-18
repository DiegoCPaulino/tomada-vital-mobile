import '../data/mock_data.dart';
import '../models/enums.dart';
import '../models/equipment.dart';

/// Keeps the list of devices and the rules to add new ones.
class EquipmentRepository {
  EquipmentRepository._();

  static final EquipmentRepository instance = EquipmentRepository._();

  final List<Equipment> _equipments = List.of(mockEquipments);

  List<Equipment> findByPatient(int patientId) {
    return _equipments.where((equipment) => equipment.patientId == patientId).toList();
  }

  Equipment? findById(int id) {
    for (final equipment in _equipments) {
      if (equipment.id == id) {
        return equipment;
      }
    }
    return null;
  }

  bool isDeviceCodeTaken(String deviceCode) {
    final code = normalizeDeviceCode(deviceCode);
    return _equipments.any((equipment) => equipment.deviceCode == code);
  }

  Equipment add({
    required int patientId,
    required EquipmentType type,
    required int batteryLifeMinutes,
    required String deviceCode,
  }) {
    final equipment = Equipment(
      id: _nextId(),
      patientId: patientId,
      type: type,
      batteryLifeMinutes: batteryLifeMinutes,
      deviceCode: normalizeDeviceCode(deviceCode),
    );
    _equipments.add(equipment);
    return equipment;
  }

  static String normalizeDeviceCode(String deviceCode) => deviceCode.trim().toUpperCase();

  int _nextId() {
    var maxId = 0;
    for (final equipment in _equipments) {
      if (equipment.id > maxId) {
        maxId = equipment.id;
      }
    }
    return maxId + 1;
  }
}
