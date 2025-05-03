import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home_screen.dart';
import 'package:flutter_app/screens/trends/trends_screen.dart';
import 'package:flutter_app/screens/history/history_screen.dart';
import 'package:flutter_app/screens/insights/insights_screen.dart';
import 'package:flutter_app/screens/profile/profile_screen.dart';
import 'package:flutter_app/widgets/custom_nav_bar.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    HomeScreen(),
    TrendsScreen(),
    HistoryScreen(),
    InsightsScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_selectedIndex)),
        actions: [
          _buildNotificationIcon(),
          _buildQuickReportIcon(), // Added new action
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0: return 'Sleep Tracking';
      case 1: return 'Trends & Charts';
      case 2: return 'Sleep History';
      case 3: return 'Insights & Tips';
      case 4: return 'Profile & Settings';
      default: return 'Smart Sleep Monitor';
    }
  }

  Widget _buildNotificationIcon() {
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: _handleNotifications,
    );
  }

  Widget _buildQuickReportIcon() {
    return IconButton(
      icon: const Icon(Icons.assessment_outlined),
      onPressed: _handleQuickReports,
    );
  }

  void _handleNotifications() {
    // Implement notification logic
  }

  void _handleQuickReports() {
    // Implement quick report generation
  }
}