import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrendsScreen extends StatelessWidget {
  const TrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildChartCard(
              context,
              title: 'Sleep Score Trend',
              chart: _buildSleepScoreChart(),
            ),
            const SizedBox(height: 16),
            _buildChartCard(
              context,
              title: 'Heart Rate Trend',
              chart: _buildHeartRateChart(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(BuildContext context, {required String title, required Widget chart}) {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepScoreChart() {
    final spots = [
      FlSpot(0, 72), FlSpot(1, 85), FlSpot(2, 78),
      FlSpot(3, 90), FlSpot(4, 88), FlSpot(5, 82),
    ];

    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(enabled: false),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: false),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRateChart() {
    final spots = [
      FlSpot(0, 68), FlSpot(1, 72), FlSpot(2, 65),
      FlSpot(3, 70), FlSpot(4, 75), FlSpot(5, 69),
    ];

    return LineChart(
      LineChartData(
        // Similar configuration to sleep score chart
      ),
    );
  }

}