import '../models/enums.dart';
import '../models/outage.dart';
import '../models/response_step.dart';
import '../utils/formatters.dart';
import '../utils/labels.dart';

/// One line of the response timeline.
class TimelineEntry {
  final String title;
  final String subtitle;
  final bool isDone;

  const TimelineEntry({required this.title, required this.subtitle, required this.isDone});
}

/// Builds the timeline of an outage: the detection, what the response
/// center already did and, while it is active, the steps still waiting.
class TimelineService {
  TimelineService._();

  static const List<ResponseAction> _expectedActions = [
    ResponseAction.teamOnTheWay,
    ResponseAction.generatorDelivered,
    ResponseAction.powerRestored,
  ];

  static List<TimelineEntry> build(Outage outage, List<ResponseStep> steps) {
    final entries = <TimelineEntry>[
      TimelineEntry(
        title: 'Queda detectada',
        subtitle: '${Formatters.time(outage.startedAt)} · o dispositivo avisou pela rede celular',
        isDone: true,
      ),
    ];

    for (final step in steps) {
      entries.add(TimelineEntry(
        title: step.action.label,
        subtitle: '${Formatters.time(step.performedAt)} · ${step.note}',
        isDone: true,
      ));
    }

    if (outage.isActive) {
      final doneActions = steps.map((step) => step.action).toSet();
      for (final action in _expectedActions) {
        if (!doneActions.contains(action)) {
          entries.add(TimelineEntry(title: action.label, subtitle: 'Aguardando', isDone: false));
        }
      }
    }
    return entries;
  }
}
