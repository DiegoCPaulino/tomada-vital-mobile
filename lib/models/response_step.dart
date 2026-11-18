import 'enums.dart';

/// One action the response center took for an outage.
class ResponseStep {
  final int id;
  final int outageId;
  final DateTime performedAt;
  final ResponseAction action;
  final String note;

  const ResponseStep({
    required this.id,
    required this.outageId,
    required this.performedAt,
    required this.action,
    required this.note,
  });
}
