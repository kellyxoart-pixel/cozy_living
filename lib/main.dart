import 'screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CozyLivingApp());
}

class CozyLivingApp extends StatelessWidget {
  const CozyLivingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Cozy Living',

      theme: AppTheme.light,

      home: const WelcomeScreen(),
    );
  }
}
