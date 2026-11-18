import 'package:flutter/material.dart';

import 'routes/app_routes.dart';
import 'screens/login/login_screen.dart';
import 'theme/app_theme.dart';

/// Root widget: theme and the first route (login).
class TomadaVitalApp extends StatelessWidget {
  const TomadaVitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomada Vital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
      },
    );
  }
}
