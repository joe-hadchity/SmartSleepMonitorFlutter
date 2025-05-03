import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/sleep_metric.dart';

class SleepChart extends StatelessWidget {
  final List<SleepMetric> data;

  const SleepChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: data.map((metric) => FlSpot(
              metric.timestamp.hour.toDouble(),
              metric.heartRate
            )).toList(),
            isCurved: true,
            color: Colors.red,
            barWidth: 4,
            dotData: const FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('${value.toInt()}h'),
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('${value.toInt()}'),
              reservedSize: 40,
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        borderData: FlBorderData(
  show: true,
  border: const Border(
    bottom: BorderSide(color: Colors.grey),
    left: BorderSide(color: Colors.grey),
  ),
),

        gridData: const FlGridData(show: true),
      ),
    );
  }
}