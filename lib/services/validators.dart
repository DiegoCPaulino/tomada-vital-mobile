import '../models/enums.dart';

/// Validation rules of every form in the app. The screens only call them.
class Validators {
  Validators._();

  static final RegExp _deviceCodePattern = RegExp(r'^TV-\d{3}$');
  static const int minUsernameLength = 4;
  static const int minPasswordLength = 6;
  static const int maxBatteryLifeMinutes = 1440;

  static String? username(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Informe o usuário';
    }
    if (text.length < minUsernameLength) {
      return 'O usuário deve ter pelo menos $minUsernameLength caracteres';
    }
    return null;
  }

  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Informe a senha';
    }
    if (text.length < minPasswordLength) {
      return 'A senha deve ter pelo menos $minPasswordLength caracteres';
    }
    return null;
  }

  static String? deviceCode(String? value, {required bool Function(String code) isTaken}) {
    final code = value?.trim().toUpperCase() ?? '';
    if (code.isEmpty) {
      return 'Informe o código do dispositivo';
    }
    if (!_deviceCodePattern.hasMatch(code)) {
      return 'Use o formato TV-000 (TV, hífen e três números)';
    }
    if (isTaken(code)) {
      return 'Já existe um equipamento com o código $code';
    }
    return null;
  }

  static String? equipmentType(EquipmentType? value) {
    return value == null ? 'Escolha o tipo de aparelho' : null;
  }

  static String? batteryLife(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Informe a autonomia da bateria';
    }
    final minutes = int.tryParse(text);
    if (minutes == null) {
      return 'Digite apenas números';
    }
    if (minutes < 0 || minutes > maxBatteryLifeMinutes) {
      return 'A autonomia deve estar entre 0 e $maxBatteryLifeMinutes minutos';
    }
    return null;
  }
}
