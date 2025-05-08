import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_app/models/sleep_stage.dart';
import 'package:flutter_app/services/sleep_service.dart';
import 'package:intl/intl.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  List<SleepStage> sleepStages = [];
  bool isLoading = true;
  String userId = 'ZTokXgPSOhQmRSnthClZec1gOXL2';
  String date = '2025-05-06';

  final Map<String, double> stageMap = {
    'Awake': 1,
    'REM': 2,
    'Core': 3,
    'Deep': 4,
  };

  final Map<double, String> yAxisLabels = {
    1: 'Awake',
    2: 'REM',
    3: 'Core',
    4: 'Deep',
  };

  final Map<String, Color> stageColors = {
    'Awake': const Color.fromARGB(255, 247, 111, 27),
    'REM': const Color.fromARGB(255, 106, 194, 244),
    'Core': const Color.fromARGB(255, 9, 77, 194),
    'Deep': const Color.fromARGB(255, 44, 27, 132),
  };

  Duration totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadSleepStages();
  }

  Future<void> _loadSleepStages() async {
    try {
      final data = await SleepService.fetchSleepStages(userId, date);
      setState(() {
        sleepStages = data;
        totalDuration = _calculateSleepDuration(data);
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading sleep stages: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Duration _calculateSleepDuration(List<SleepStage> stages) {
    if (stages.isEmpty) return Duration.zero;
    final start = (stages.first.timestamp);
    final end = (stages.last.timestamp);
    return end.difference(start);
  }

  Map<String, Duration> _calculateStageDurations() {
    final Map<String, Duration> durations = {
      'Awake': Duration.zero,
      'REM': Duration.zero,
      'Core': Duration.zero,
      'Deep': Duration.zero,
    };

    for (int i = 0; i < sleepStages.length - 1; i++) {
      final current = sleepStages[i];
      final next = sleepStages[i + 1];
      final duration = next.timestamp.difference(current.timestamp);
      if (durations.containsKey(current.stage)) {
        durations[current.stage] = durations[current.stage]! + duration;
      }
    }

    return durations;
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < sleepStages.length; i += 3) {
      final stage = sleepStages[i].stage;
      final y = stageMap[stage];
      if (y != null) {
        final color = stageColors[stage] ?? Colors.grey;
        barGroups.add(
          BarChartGroupData(
            x: i ~/ 3,
            barRods: [
              BarChartRodData(
                fromY: y - 0.2,
                toY: y,
                width: 6,
                color: color.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }
    }
    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_formatDuration(totalDuration)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d MMM yyyy').format(DateTime.parse(date)),
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  _buildChartCard(
                    context,
                    title: 'Sleep Stage Graph',
                    chart: _buildSleepStageChart(),
                  ),
                  _buildStageDurations(),
                ],
              ),
            ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours} hr ${minutes.toString().padLeft(2, '0')} min';
  }

  Widget _buildChartCard(BuildContext context,
      {required String title, required Widget chart}) {
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 300, child: chart),
          ],
        ),
      ),
    );
  }

  Widget _buildStageDurations() {
    final durations = _calculateStageDurations();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: durations.entries.map((entry) {
        final stage = entry.key;
        final color = stageColors[stage]!;
        final duration = entry.value;
        final formatted = _formatDuration(duration);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                stage,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Spacer(),
              Text(
                formatted,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSleepStageChart() {
    final barGroups = _buildBarGroups();
    final labelIndexes = {20, 60, 100, 140}; // 1AM, 3AM, 5AM, 7AM

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        barGroups: barGroups,
        minY: 0,
        maxY: 5,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: labelIndexes.contains(value.toInt() * 3)
                  ? Colors.white24
                  : Colors.transparent,
              strokeWidth: 0.5,
              dashArray: [4, 4],
            );
          },
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white24,
            strokeWidth: 0.5,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: (value, _) {
                final label = yAxisLabels[value] ?? '';
                return Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, _) {
                int index = value.toInt() * 3;
                if (index < sleepStages.length &&
                    [20, 60, 100, 140].contains(index)) {
                  final time =
                      DateFormat('h a').format((sleepStages[index].timestamp));
                  return Text(time,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 10));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black87,
            tooltipPadding: const EdgeInsets.all(8),
            tooltipRoundedRadius: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final index = group.x.toInt() * 3;
              if (index < sleepStages.length) {
                final stage = sleepStages[index].stage;
                final time =
                    DateFormat('HH:mm').format(sleepStages[index].timestamp);
                return BarTooltipItem(
                  '$time\n$stage',
                  const TextStyle(color: Colors.white, fontSize: 12),
                );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
