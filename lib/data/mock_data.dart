import '../models/enums.dart';
import '../models/equipment.dart';
import '../models/outage.dart';
import '../models/patient.dart';
import '../models/response_step.dart';
import '../models/support_point.dart';

// Sample data used while the app has no backend.
// It is the same data loaded into the Oracle database of the project.
// The family that logs in is the family of patient 1 (devices TV-001 and TV-002).

const List<Patient> mockPatients = [
  Patient(id: 1, name: 'Maria Aparecida Souza', neighborhood: 'Parque Pinheiros', city: 'Taboão da Serra', phone: '(11) 90000-0001'),
  Patient(id: 2, name: 'José Carlos Lima', neighborhood: 'Jardim Record', city: 'Taboão da Serra', phone: '(11) 90000-0002'),
  Patient(id: 3, name: 'Antônia Ferreira', neighborhood: 'Campo Limpo', city: 'São Paulo', phone: '(11) 90000-0003'),
  Patient(id: 4, name: 'Sebastião Rocha', neighborhood: 'Jabaquara', city: 'São Paulo', phone: '(11) 90000-0004'),
  Patient(id: 5, name: 'Helena Martins', neighborhood: 'Santo Amaro', city: 'São Paulo', phone: '(11) 90000-0005'),
  Patient(id: 6, name: 'Raimundo Alves', neighborhood: 'Pedreira', city: 'São Paulo', phone: '(11) 90000-0006'),
  Patient(id: 7, name: 'Lúcia Gomes', neighborhood: 'Centro', city: 'Cotia', phone: '(11) 90000-0007'),
  Patient(id: 8, name: 'Francisco Nunes', neighborhood: 'Granja Viana', city: 'Cotia', phone: '(11) 90000-0008'),
  Patient(id: 9, name: 'Teresa Cardoso', neighborhood: 'Rudge Ramos', city: 'São Bernardo do Campo', phone: '(11) 90000-0009'),
  Patient(id: 10, name: 'Benedito Ramos', neighborhood: 'Vila Mariana', city: 'São Paulo', phone: '(11) 90000-0010'),
];

const List<Equipment> mockEquipments = [
  Equipment(id: 1, patientId: 1, type: EquipmentType.oxygenConcentrator, batteryLifeMinutes: 480, deviceCode: 'TV-001'),
  Equipment(id: 2, patientId: 1, type: EquipmentType.suctionDevice, batteryLifeMinutes: 240, deviceCode: 'TV-002'),
  Equipment(id: 3, patientId: 2, type: EquipmentType.ventilator, batteryLifeMinutes: 360, deviceCode: 'TV-003'),
  Equipment(id: 4, patientId: 3, type: EquipmentType.oxygenConcentrator, batteryLifeMinutes: 300, deviceCode: 'TV-004'),
  Equipment(id: 5, patientId: 4, type: EquipmentType.infusionPump, batteryLifeMinutes: 600, deviceCode: 'TV-005'),
  Equipment(id: 6, patientId: 5, type: EquipmentType.oxygenConcentrator, batteryLifeMinutes: 480, deviceCode: 'TV-006'),
  Equipment(id: 7, patientId: 6, type: EquipmentType.suctionDevice, batteryLifeMinutes: 180, deviceCode: 'TV-007'),
  Equipment(id: 8, patientId: 7, type: EquipmentType.ventilator, batteryLifeMinutes: 0, deviceCode: 'TV-008'),
  Equipment(id: 9, patientId: 8, type: EquipmentType.oxygenConcentrator, batteryLifeMinutes: 420, deviceCode: 'TV-009'),
  Equipment(id: 10, patientId: 9, type: EquipmentType.ventilator, batteryLifeMinutes: 720, deviceCode: 'TV-010'),
  Equipment(id: 11, patientId: 10, type: EquipmentType.other, batteryLifeMinutes: 120, deviceCode: 'TV-011'),
];

final List<Outage> mockOutages = [
  Outage(id: 1, equipmentId: 1, startedAt: DateTime(2026, 11, 8, 14, 2), batteryPercent: 20, remainingMinutes: 96, priority: Priority.critical, status: OutageStatus.inProgress),
  Outage(id: 2, equipmentId: 3, startedAt: DateTime(2026, 11, 8, 14, 5), batteryPercent: 70, remainingMinutes: 252, priority: Priority.high, status: OutageStatus.open),
  Outage(id: 3, equipmentId: 4, startedAt: DateTime(2026, 11, 8, 14, 6), batteryPercent: 50, remainingMinutes: 150, priority: Priority.high, status: OutageStatus.open),
  Outage(id: 4, equipmentId: 5, startedAt: DateTime(2026, 11, 8, 14, 8), batteryPercent: 90, remainingMinutes: 540, priority: Priority.moderate, status: OutageStatus.open),
  Outage(id: 5, equipmentId: 8, startedAt: DateTime(2026, 11, 8, 14, 10), batteryPercent: 0, remainingMinutes: 0, priority: Priority.critical, status: OutageStatus.inProgress),
  Outage(id: 6, equipmentId: 6, startedAt: DateTime(2026, 11, 8, 14, 12), batteryPercent: 35, remainingMinutes: 168, priority: Priority.high, status: OutageStatus.open),
  Outage(id: 7, equipmentId: 7, startedAt: DateTime(2026, 11, 8, 14, 15), batteryPercent: 60, remainingMinutes: 108, priority: Priority.critical, status: OutageStatus.open),
  Outage(id: 8, equipmentId: 9, startedAt: DateTime(2025, 12, 10, 18, 30), endedAt: DateTime(2025, 12, 10, 22, 10), batteryPercent: 80, remainingMinutes: 336, priority: Priority.high, status: OutageStatus.resolved),
  Outage(id: 9, equipmentId: 10, startedAt: DateTime(2025, 12, 10, 19, 0), endedAt: DateTime(2025, 12, 11, 1, 0), batteryPercent: 100, remainingMinutes: 720, priority: Priority.moderate, status: OutageStatus.resolved),
  Outage(id: 10, equipmentId: 2, startedAt: DateTime(2024, 10, 11, 17, 40), endedAt: DateTime(2024, 10, 11, 21, 10), batteryPercent: 100, remainingMinutes: 240, priority: Priority.high, status: OutageStatus.resolved),
];

final List<ResponseStep> mockResponseSteps = [
  ResponseStep(id: 1, outageId: 1, performedAt: DateTime(2026, 11, 8, 14, 18), action: ResponseAction.teamOnTheWay, note: 'Previsão de chegada às 14:45'),
  ResponseStep(id: 2, outageId: 5, performedAt: DateTime(2026, 11, 8, 14, 12), action: ResponseAction.teamOnTheWay, note: 'Aparelho sem bateria: prioridade máxima'),
  ResponseStep(id: 3, outageId: 5, performedAt: DateTime(2026, 11, 8, 14, 35), action: ResponseAction.generatorDelivered, note: 'Gerador portátil instalado na casa'),
  ResponseStep(id: 4, outageId: 8, performedAt: DateTime(2025, 12, 10, 18, 50), action: ResponseAction.teamOnTheWay, note: 'Equipe saiu da base Cotia'),
  ResponseStep(id: 5, outageId: 8, performedAt: DateTime(2025, 12, 10, 19, 20), action: ResponseAction.generatorDelivered, note: 'Gerador entregue à família'),
  ResponseStep(id: 6, outageId: 8, performedAt: DateTime(2025, 12, 10, 22, 10), action: ResponseAction.powerRestored, note: 'Rede religada pela concessionária'),
  ResponseStep(id: 7, outageId: 9, performedAt: DateTime(2025, 12, 10, 21, 0), action: ResponseAction.patientRelocated, note: 'Paciente levada a ponto de apoio com gerador'),
  ResponseStep(id: 8, outageId: 9, performedAt: DateTime(2025, 12, 11, 1, 0), action: ResponseAction.powerRestored, note: 'Rede religada e paciente voltou para casa'),
  ResponseStep(id: 9, outageId: 10, performedAt: DateTime(2024, 10, 11, 18, 10), action: ResponseAction.teamOnTheWay, note: 'Equipe a caminho'),
  ResponseStep(id: 10, outageId: 10, performedAt: DateTime(2024, 10, 11, 21, 10), action: ResponseAction.powerRestored, note: 'Rede religada pela concessionária'),
];

const List<SupportPoint> mockSupportPoints = [
  SupportPoint(id: 1, name: 'UBS Jardim das Flores', distance: '1,2 km', resource: 'Gerador 24 h', slots: 12),
  SupportPoint(id: 2, name: 'Escola Municipal Monteiro', distance: '1,8 km', resource: 'Gerador 12 h', slots: 30),
  SupportPoint(id: 3, name: 'Centro Comunitário Vila Nova', distance: '2,5 km', resource: 'Nobreak 6 h', slots: 8),
  SupportPoint(id: 4, name: 'Posto de Bombeiros 3', distance: '3,1 km', resource: 'Cilindros de oxigênio', slots: 4),
];
