/// Formatting helpers for times and durations shown on screen.
class Formatters {
  Formatters._();

  /// 14:02
  static String time(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  /// 480 -> "8 h (480 min)", 90 -> "1 h 30 min (90 min)", 0 -> "Sem bateria"
  static String batteryLife(int minutes) {
    if (minutes == 0) {
      return 'Sem bateria';
    }
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    if (hours == 0) {
      return '$minutes min';
    }
    final duration = rest == 0 ? '$hours h' : '$hours h $rest min';
    return '$duration ($minutes min)';
  }

  /// 2 -> "2º"
  static String queuePosition(int position) => '$positionº';
}
