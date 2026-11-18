import '../data/mock_data.dart';
import '../models/support_point.dart';

/// Gives access to the places with backup power.
class SupportPointRepository {
  SupportPointRepository._();

  static final SupportPointRepository instance = SupportPointRepository._();

  List<SupportPoint> findAll() => List.unmodifiable(mockSupportPoints);
}
