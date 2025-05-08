// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables
  late String greeting;
  final int bodyBattery = 65;
  final int recovery = 1;
  final String stressLevel = '--';
  late DateTime lastUpdated;
  final int netEnergy = -63;
  int sleepScore = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    greeting = _getTimeBasedGreeting();
    lastUpdated = DateTime.now();
    _fetchSleepScore();
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  Future<void> _fetchSleepScore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/sleep-score/${user.uid}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          sleepScore = data['score'] ?? 0;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
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

  Widget _buildHealthMetrics(
      BuildContext context, int battery, int recovery, String stress) {
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
      {required String title,
      required String value,
      required String subtitle}) {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  String _getSleepQuality(int score) {
    if (score >= 85) return 'Excellent';
    if (score >= 70) return 'Good';
    if (score >= 50) return 'Fair';
    return 'Poor';
  }

  Widget _buildHealthDataSection(BuildContext context, int sleep, int energy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Data',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        _buildDataRow(context, 'Sleep', '${isLoading ? '--' : '$sleep%'}',
            isLoading ? 'Loading' : _getSleepQuality(sleep)),
        _buildDataRow(context, 'Net Energy', '${energy}kcal', 'Balanced'),
      ],
    );
  }

  Widget _buildDataRow(
      BuildContext context, String title, String value, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(width: 16),
          Chip(
            label: Text(status),
            backgroundColor: _getStatusColor(status),
            labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: _getStatusTextColor(status),
                ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Excellent':
        return Colors.green.withOpacity(0.2);
      case 'Good':
        return Colors.lightGreen.withOpacity(0.2);
      case 'Fair':
        return Colors.orange.withOpacity(0.2);
      case 'Poor':
        return Colors.red.withOpacity(0.2);
      case 'Loading':
        return Colors.grey.withOpacity(0.2);
      default:
        return Colors.green.withOpacity(0.2);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Excellent':
        return Colors.green;
      case 'Good':
        return Colors.lightGreen;
      case 'Fair':
        return Colors.orange;
      case 'Poor':
        return Colors.red;
      case 'Loading':
        return Colors.grey;
      default:
        return Colors.green;
    }
  }

  Widget _buildWorkoutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workouts',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          'No workouts today',
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

  @override
  Widget build(BuildContext context) {
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
            _buildHealthDataSection(context, sleepScore, netEnergy),
            const SizedBox(height: 24),
            _buildWorkoutSection(context),
            const SizedBox(height: 24),
            _buildLastUpdated(context, lastUpdated),
          ],
        ),
      ),
    );
  }
}
