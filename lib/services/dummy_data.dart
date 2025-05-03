import 'package:flutter_app/models/sleep_metric.dart';
import 'package:flutter_app/models/sleep_report.dart';
import 'dart:math';

class DummyDataService {
  static final Random _random = Random();

  static List<SleepMetric> generateDummyMetrics() {
    return List.generate(24, (index) => SleepMetric(
      timestamp: DateTime.now().subtract(Duration(hours: 24 - index)),
      heartRate: 60 + _random.nextDouble() * 20,
      temperature: 20 + _random.nextDouble() * 5,
      humidity: 30 + _random.nextDouble() * 20,
      movement: _random.nextInt(100),
      sleepScore: 50 + _random.nextDouble() * 50,
    ));
  }

  static List<SleepReport> generateDummyReports() => [
    SleepReport(
      date: DateTime.now().subtract(Duration(days: 1)),
      score: 82.5,
      analysis: 'Good sleep duration with minor disturbances',
      recommendations: [
        'Keep bedroom temperature between 18-22°C',
        'Avoid screens 1 hour before bedtime'
      ],
    ),
    SleepReport(
      date: DateTime.now().subtract(Duration(days: 2)),
      score: 68.3,
      analysis: 'Frequent movements detected during sleep',
      recommendations: [
        'Try relaxation exercises before bed',
        'Maintain consistent sleep schedule'
      ],
    ),
  ];
}