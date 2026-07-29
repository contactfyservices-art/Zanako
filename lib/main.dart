import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const ZanakoApp());
}

class ZanakoApp extends StatelessWidget {
  const ZanakoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zanako',
      debugShowCheckedModeBanner: false,
      theme: buildZanakoTheme(),
      home: const WelcomeScreen(),
    );
  }
}
