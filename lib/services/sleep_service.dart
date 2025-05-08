import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/sleep_stage.dart';

class SleepService {
  static Future<List<SleepStage>> fetchSleepStages(
      String userId, String date) async {
    // Use appropriate base URL depending on whether you're on web or not
    const baseUrl = kIsWeb ? 'http://127.0.0.1:8000' : 'http://10.0.2.2:8000';

    final url = Uri.parse('$baseUrl/sleep-session/$userId?date=$date');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final stages = data['stages'] as List<dynamic>;
      return stages.map((e) => SleepStage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sleep data');
    }
  }
}
