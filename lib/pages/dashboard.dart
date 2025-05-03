import 'package:flutter/material.dart';
import 'package:flutter_app/models/sleep_metric.dart';
import 'package:flutter_app/services/dummy_data.dart';
import 'package:flutter_app/widgets/metric_card.dart';
import 'package:flutter_app/widgets/sleep_chart.dart';
import 'report_history.dart';
class DashboardScreen extends StatelessWidget {
  final List<SleepMetric> metrics = DummyDataService.generateDummyMetrics();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lastMetric = metrics.last;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportHistoryScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1.5,
              children: [
                MetricCard(
                  title: 'Heart Rate',
                  value: '${lastMetric.heartRate.toStringAsFixed(1)} BPM',
                  color: Colors.red,
                ),
                MetricCard(
                  title: 'Temperature',
                  value: '${lastMetric.temperature.toStringAsFixed(1)}°C',
                  color: Colors.blue,
                ),
                MetricCard(
                  title: 'Humidity',
                  value: '${lastMetric.humidity.toStringAsFixed(1)}%',
                  color: Colors.green,
                ),
                MetricCard(
                  title: 'Sleep Score',
                  value: '${lastMetric.sleepScore.toStringAsFixed(1)}/100',
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Sleep Metrics History', 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 250,
              child: SleepChart(data: metrics),
            ),
          ],
        ),
      ),
    );
  }
}