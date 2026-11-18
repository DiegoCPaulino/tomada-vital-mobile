import '../data/mock_data.dart';
import '../models/patient.dart';

/// Gives access to the patients. Today it reads the sample data.
class PatientRepository {
  PatientRepository._();

  static final PatientRepository instance = PatientRepository._();

  final List<Patient> _patients = List.of(mockPatients);

  Patient? findById(int id) {
    for (final patient in _patients) {
      if (patient.id == id) {
        return patient;
      }
    }
    return null;
  }
}
