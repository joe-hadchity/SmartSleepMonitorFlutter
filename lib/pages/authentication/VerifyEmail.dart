import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  Future<void> checkVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();
    if (user?.emailVerified ?? false) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
                "A verification email has been sent. Please verify and click below."),
            ElevatedButton(
              onPressed: () => checkVerification(context),
              child: const Text("I Verified"),
            ),
          ],
        ),
      ),
    );
  }
}
