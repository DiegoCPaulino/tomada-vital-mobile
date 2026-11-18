import '../models/patient.dart';
import '../repositories/patient_repository.dart';

/// Login with the test account of the family of patient 1.
/// There is no backend in this version, so the credentials are fixed.
class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  static const String demoUsername = 'familia1';
  static const String demoPassword = '123456';
  static const int _demoPatientId = 1;

  /// Returns the patient of the family, or null when the login fails.
  Patient? login(String username, String password) {
    if (username.trim() == demoUsername && password == demoPassword) {
      return PatientRepository.instance.findById(_demoPatientId);
    }
    return null;
  }
}
