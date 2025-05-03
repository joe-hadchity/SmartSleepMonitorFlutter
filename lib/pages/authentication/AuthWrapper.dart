import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/navigation/main_navigation_wrapper.dart';
import 'package:flutter_app/pages/authentication/Login.dart';
import 'package:flutter_app/pages/authentication/VerifyEmail.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final user = snapshot.data;
        if (user == null) {
          return const LoginPage();
        } else if (!user.emailVerified) {
          return const VerifyEmailPage();
        } else {
          return const MainNavigationWrapper();
        }
      },
    );
  }
}
