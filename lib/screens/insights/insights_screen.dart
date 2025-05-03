import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRecoveryCard(),
            const SizedBox(height: 16),
            _buildRecommendationsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecoveryCard() {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Current Recovery Status',
              style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            CircularProgressIndicator(
              value: 0.65,
              color: Colors.blueAccent,
              backgroundColor: Colors.grey[800],
            ),
            const SizedBox(height: 16),
            const Text('65% Recovery',
              style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsList() {
    final recommendations = [
      _Recommendation(Icons.nights_stay, 'Consistent Bedtime', 
        'Try going to bed within 30 minutes of your usual time'),
      _Recommendation(Icons.coffee, 'Limit Caffeine', 
        'Avoid caffeine after 2 PM'),
      _Recommendation(Icons.device_thermostat, 'Room Temperature', 
        'Keep bedroom between 60-67°F (15-19°C)'),
    ];

    return Card(
      color: const Color(0xFF1F1F1F),
      child: Column(
        children: recommendations.map((rec) => ListTile(
          leading: Icon(rec.icon, color: Colors.blueAccent),
          title: Text(rec.title, style: const TextStyle(color: Colors.white)),
          subtitle: Text(rec.subtitle, style: const TextStyle(color: Colors.grey)),
        )).toList(),
      ),
    );
  }
}

class _Recommendation {
  final IconData icon;
  final String title;
  final String subtitle;

  _Recommendation(this.icon, this.title, this.subtitle);
}