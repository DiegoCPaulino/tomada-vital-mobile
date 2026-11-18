import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../../models/patient.dart';
import '../../repositories/equipment_repository.dart';
import '../../services/validators.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../utils/labels.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

/// Form to register a new device for the [patient].
/// Returns the created device to the previous screen.
class EquipmentFormScreen extends StatefulWidget {
  const EquipmentFormScreen({super.key, required this.patient});

  final Patient patient;

  @override
  State<EquipmentFormScreen> createState() => _EquipmentFormScreenState();
}

class _EquipmentFormScreenState extends State<EquipmentFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _batteryLifeController = TextEditingController();
  final EquipmentRepository _repository = EquipmentRepository.instance;
  EquipmentType? _selectedType;

  @override
  void dispose() {
    _codeController.dispose();
    _batteryLifeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final equipment = _repository.add(
      patientId: widget.patient.id,
      type: _selectedType!,
      batteryLifeMinutes: int.parse(_batteryLifeController.text.trim()),
      deviceCode: _codeController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${equipment.deviceCode} cadastrado com sucesso')),
    );
    Navigator.pop(context, equipment);
  }

  @override
  Widget build(BuildContext context) {
    final fieldBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.fieldRadius));
    return Scaffold(
      appBar: const AppHeader(title: 'Cadastrar equipamento'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informe o aparelho de ${widget.patient.name} e o código do dispositivo Tomada Vital ligado a ele.',
                style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                controller: _codeController,
                label: 'Código do dispositivo',
                hint: 'TV-012',
                textCapitalization: TextCapitalization.characters,
                validator: (value) => Validators.deviceCode(value, isTaken: _repository.isDeviceCodeTaken),
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<EquipmentType>(
                initialValue: _selectedType,
                validator: Validators.equipmentType,
                decoration: InputDecoration(
                  labelText: 'Tipo de aparelho',
                  filled: true,
                  fillColor: AppColors.surface,
                  border: fieldBorder,
                  enabledBorder: fieldBorder.copyWith(borderSide: const BorderSide(color: AppColors.border)),
                ),
                items: EquipmentType.values
                    .map((type) => DropdownMenuItem(value: type, child: Text(type.label)))
                    .toList(),
                onChanged: (type) => setState(() => _selectedType = type),
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _batteryLifeController,
                label: 'Autonomia da bateria (minutos)',
                helper: 'De 0 a ${Validators.maxBatteryLifeMinutes}. Use 0 se o aparelho não tem bateria.',
                keyboardType: TextInputType.number,
                validator: Validators.batteryLife,
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(label: 'Salvar equipamento', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
