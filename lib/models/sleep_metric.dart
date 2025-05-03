class SleepMetric {
  final DateTime timestamp;
  final double heartRate;
  final double temperature;
  final double humidity;
  final int movement;
  final double sleepScore;

  SleepMetric({
    required this.timestamp,
    required this.heartRate,
    required this.temperature,
    required this.humidity,
    required this.movement,
    required this.sleepScore,
  });
}