import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/models/sleep_report.dart';
import 'package:flutter_app/services/dummy_data.dart';

class ReportHistoryScreen extends StatelessWidget {
  final List<SleepReport> reports = DummyDataService.generateDummyReports();

  ReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sleep Reports')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            child: ListTile(
              leading: Icon(
                report.score >= 80 ? Icons.sentiment_very_satisfied :
                report.score >= 60 ? Icons.sentiment_neutral :
                Icons.sentiment_very_dissatisfied,
                color: report.score >= 80 ? Colors.green : 
                       report.score >= 60 ? Colors.amber : Colors.red,
              ),
              title: Text('${report.score.toStringAsFixed(1)} Sleep Score'),
              subtitle: Text(DateFormat.yMMMd().format(report.date)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showReportDetails(context, report),
            ),
          );
        },
      ),
    );
  }

  void _showReportDetails(BuildContext context, SleepReport report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sleep Report - ${DateFormat.yMMMd().format(report.date)}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Score: ${report.score.toStringAsFixed(1)}'),
            const SizedBox(height: 16),
            Text(report.analysis),
            const SizedBox(height: 16),
            const Text('Recommendations:', 
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...report.recommendations.map((r) => Text('• $r')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}