import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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

      theme: ThemeData(
        fontFamily: 'Arial',
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}