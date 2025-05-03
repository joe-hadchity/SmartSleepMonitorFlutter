// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final greeting = _getTimeBasedGreeting();
    final bodyBattery = 65;
    final recovery = 1;
    final stressLevel = '--';
    final lastUpdated = DateTime.now();
    final sleepData = 100;
    final netEnergy = -63;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(context, greeting),
            const SizedBox(height: 20),
            _buildSuggestionCard(context),
            const SizedBox(height: 24),
            _buildHealthMetrics(context, bodyBattery, recovery, stressLevel),
            const SizedBox(height: 24),
            _buildHealthDataSection(context, sleepData, netEnergy),
            const SizedBox(height: 24),
            _buildWorkoutSection(context),
            const SizedBox(height: 24),
            _buildLastUpdated(context, lastUpdated),
          ],
        ),
      ),
    );
  }

  // Keep all the helper methods except _buildBodyBatteryChart
  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  Widget _buildGreeting(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSuggestionCard(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.warning_amber, color: Colors.amber),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Your body has ample energy. But Recovery is extremely low. '
                'It\'s advised to rest to allow your body to recover fully and avoid overexertion.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetrics(BuildContext context, int battery, int recovery, String stress) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            context,
            title: 'Body Battery',
            value: '$battery%',
            subtitle: 'Stress $stress',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(
            context,
            title: 'Recovery',
            value: '$recovery%',
            subtitle: 'Fatigued',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, 
      {required String title, required String value, required String subtitle}) {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, 
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 8),
            Text(title, 
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            Text(subtitle, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthDataSection(BuildContext context, int sleep, int energy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Health Data', 
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildDataRow(context, 'Sleep', '$sleep%', 'Ideal'),
        _buildDataRow(context, 'Net Energy', '${energy}kcal', 'Balanced'),
      ],
    );
  }

  Widget _buildDataRow(BuildContext context, String title, String value, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(title, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
              ),
            ),
          ),
          Text(value, 
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Chip(
            label: Text(status),
            backgroundColor: Colors.green.withOpacity(0.2),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Workouts', 
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text('No workouts today', 
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLastUpdated(BuildContext context, DateTime time) {
    return Text(
      'Last updated at ${DateFormat.Hm().format(time)}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey,
      ),
    );
  }
}