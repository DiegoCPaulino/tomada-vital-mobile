import '../models/enums.dart';
import '../models/outage.dart';

/// The priority rule of Tomada Vital. It is the same rule used by the
/// database, the API and the device:
/// remaining minutes = battery life x battery % / 100 - minutes since the outage
/// up to 120 min (or no battery) = critical, 121 to 360 = high, above = moderate.
class PriorityService {
  PriorityService._();

  static const int criticalLimitMinutes = 120;
  static const int highLimitMinutes = 360;

  static int calculateRemainingMinutes({
    required int batteryLifeMinutes,
    required int batteryPercent,
    int minutesSinceOutage = 0,
  }) {
    final remaining = (batteryLifeMinutes * batteryPercent / 100).round() - minutesSinceOutage;
    return remaining < 0 ? 0 : remaining;
  }

  static Priority classify({
    required int batteryLifeMinutes,
    required int remainingMinutes,
  }) {
    if (batteryLifeMinutes == 0 || remainingMinutes <= criticalLimitMinutes) {
      return Priority.critical;
    }
    if (remainingMinutes <= highLimitMinutes) {
      return Priority.high;
    }
    return Priority.moderate;
  }

  /// Queue order: fewer minutes left first; on a tie, whoever lost power first.
  static int compareQueueOrder(Outage a, Outage b) {
    final byMinutes = a.remainingMinutes.compareTo(b.remainingMinutes);
    return byMinutes != 0 ? byMinutes : a.startedAt.compareTo(b.startedAt);
  }
}
