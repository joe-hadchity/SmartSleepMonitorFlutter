import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 7,
        itemBuilder: (context, index) => _buildSleepSessionCard(index),
      ),
    );
  }

  Widget _buildSleepSessionCard(int index) {
    final fakeDate = DateTime.now().subtract(Duration(days: index));
    return Card(
      color: const Color(0xFF1F1F1F),
      child: ExpansionTile(
        title: Text(DateFormat('MMMM dd, y').format(fakeDate),
          style: const TextStyle(color: Colors.white)),
        subtitle: Text('${7 + index}h ${30 - index}m sleep',
          style: const TextStyle(color: Colors.grey)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildStatRow('Sleep Score', '${80 + index}%'),
                _buildStatRow('Disturbances', '${index + 2} times'),
                _buildStatRow('Efficiency', '${90 - index}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}