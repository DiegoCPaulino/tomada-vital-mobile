/// A place with backup power where a family can take the patient.
class SupportPoint {
  final int id;
  final String name;
  final String distance;
  final String resource;
  final int slots;

  const SupportPoint({
    required this.id,
    required this.name,
    required this.distance,
    required this.resource,
    required this.slots,
  });
}
