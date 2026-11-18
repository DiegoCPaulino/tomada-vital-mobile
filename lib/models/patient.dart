/// A person who depends on a powered medical device at home.
class Patient {
  final int id;
  final String name;
  final String neighborhood;
  final String city;
  final String phone;

  const Patient({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.city,
    required this.phone,
  });
}
