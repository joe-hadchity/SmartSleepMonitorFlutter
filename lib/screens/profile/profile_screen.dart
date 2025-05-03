import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                Text('Registered since 2023',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Card(
      color: const Color(0xFF1F1F1F),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Sleep Reminders',
                style: TextStyle(color: Colors.white)),
            subtitle: const Text('Daily bedtime notifications',
                style: TextStyle(color: Colors.grey)),
            value: true,
            onChanged: (value) {},
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.devices, color: Colors.blueAccent),
            title: const Text('Connected Devices',
                style: TextStyle(color: Colors.white)),
            onTap: () {/* Navigate to devices */},
          ),
          const Divider(color: Colors.grey),
          ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // If you're using an AuthWrapper or similar mechanism,
                // it will handle the redirection upon sign-out.
              }),
        ],
      ),
    );
  }
}
