import '../data/mock_data.dart';
import '../models/outage.dart';
import '../models/response_step.dart';
import '../services/priority_service.dart';

/// Keeps the outages, the response queue and the steps of each response.
class OutageRepository {
  OutageRepository._();

  static final OutageRepository instance = OutageRepository._();

  final List<Outage> _outages = List.of(mockOutages);
  final List<ResponseStep> _steps = List.of(mockResponseSteps);

  Outage? findActiveByEquipment(int equipmentId) {
    for (final outage in _outages) {
      if (outage.equipmentId == equipmentId && outage.isActive) {
        return outage;
      }
    }
    return null;
  }

  /// Active outages in the order the response center serves them.
  List<Outage> activeQueue() {
    final queue = _outages.where((outage) => outage.isActive).toList();
    queue.sort(PriorityService.compareQueueOrder);
    return queue;
  }

  /// Position of the outage in the response queue (1 = next to be served).
  int? queuePositionOf(Outage outage) {
    final queue = activeQueue();
    final index = queue.indexWhere((item) => item.id == outage.id);
    return index == -1 ? null : index + 1;
  }

  void save(Outage outage) {
    final index = _outages.indexWhere((item) => item.id == outage.id);
    if (index == -1) {
      _outages.add(outage);
    } else {
      _outages[index] = outage;
    }
  }

  int nextOutageId() => _outages.fold<int>(0, (maxId, item) => item.id > maxId ? item.id : maxId) + 1;

  List<ResponseStep> stepsOf(int outageId) {
    final steps = _steps.where((step) => step.outageId == outageId).toList();
    steps.sort((a, b) => a.performedAt.compareTo(b.performedAt));
    return steps;
  }

  void addStep(ResponseStep step) => _steps.add(step);

  int nextStepId() => _steps.fold<int>(0, (maxId, item) => item.id > maxId ? item.id : maxId) + 1;
}
