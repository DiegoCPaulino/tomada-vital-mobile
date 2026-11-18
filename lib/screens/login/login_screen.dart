import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/validators.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../widgets/app_card.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';

/// Login of the family. Validates the fields and, when the credentials
/// are right, opens the Home screen with the patient of the family.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final patient = AuthService.instance.login(_usernameController.text, _passwordController.text);
    if (patient == null) {
      _showLoginError();
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen(patient: patient)),
    );
  }

  void _showLoginError() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Não foi possível entrar'),
        content: const Text('Usuário ou senha incorretos. Confira os dados e tente de novo.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 56, AppSpacing.lg, AppSpacing.lg),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', width: 96, height: 96),
              const SizedBox(height: 14),
              const Text(
                'Tomada Vital',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              const Text(
                'Acompanhe a sua casa quando a energia cair',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _usernameController,
                        label: 'Usuário',
                        validator: Validators.username,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppTextField(
                        controller: _passwordController,
                        label: 'Senha',
                        obscureText: _hidePassword,
                        validator: Validators.password,
                        suffixIcon: IconButton(
                          tooltip: _hidePassword ? 'Mostrar senha' : 'Esconder senha',
                          icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _hidePassword = !_hidePassword),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      PrimaryButton(label: 'Entrar', onPressed: _submit),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Usuário de teste: ${AuthService.demoUsername} · senha ${AuthService.demoPassword}',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 4),
              const Text(
                'O dispositivo mede a tomada, nunca o paciente.',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
