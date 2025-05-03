import 'package:flutter/material.dart';
import 'package:flutter_app/pages/app_theme.dart';
import 'package:flutter_app/navigation/main_navigation_wrapper.dart'; 

void main() => runApp(const SleepMonitorApp());

class SleepMonitorApp extends StatelessWidget {
  const SleepMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Sleep Monitor',
      theme: AppTheme.darkTheme,
      home: const MainNavigationWrapper(),
    );
  }
}