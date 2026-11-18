import '../models/enums.dart';

// Texts shown on screen for each enum value. The code stays in English;
// what the user reads stays in Portuguese.

extension EquipmentTypeLabel on EquipmentType {
  String get label => switch (this) {
        EquipmentType.oxygenConcentrator => 'Concentrador de oxigênio',
        EquipmentType.ventilator => 'Ventilador',
        EquipmentType.suctionDevice => 'Aspirador de secreção',
        EquipmentType.infusionPump => 'Bomba de infusão',
        EquipmentType.other => 'Outro',
      };
}

extension PriorityLabel on Priority {
  String get label => switch (this) {
        Priority.critical => 'CRÍTICA',
        Priority.high => 'ALTA',
        Priority.moderate => 'MODERADA',
      };
}

extension OutageStatusLabel on OutageStatus {
  String get label => switch (this) {
        OutageStatus.open => 'Aberta',
        OutageStatus.inProgress => 'Em atendimento',
        OutageStatus.resolved => 'Resolvida',
      };
}

extension ResponseActionLabel on ResponseAction {
  String get label => switch (this) {
        ResponseAction.teamOnTheWay => 'Equipe a caminho',
        ResponseAction.generatorDelivered => 'Gerador entregue',
        ResponseAction.patientRelocated => 'Paciente levado ao ponto de apoio',
        ResponseAction.powerRestored => 'Energia restabelecida',
      };
}
