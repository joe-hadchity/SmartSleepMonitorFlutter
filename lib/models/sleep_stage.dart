class SleepStage {
  final DateTime timestamp;
  final String stage;

  SleepStage({required this.timestamp, required this.stage});

  factory SleepStage.fromJson(Map<String, dynamic> json) {
    return SleepStage(
      timestamp: DateTime.parse(json['timestamp']),
      stage: json['stage'],
    );
  }
}
