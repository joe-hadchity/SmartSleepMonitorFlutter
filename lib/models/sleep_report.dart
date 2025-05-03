class SleepReport {
  final DateTime date;
  final double score;
  final String analysis;
  final List<String> recommendations;

  SleepReport({
    required this.date,
    required this.score,
    required this.analysis,
    required this.recommendations,
  });
}