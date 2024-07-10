import 'package:authentication_api/views/bottom_nav.dart';
import 'package:authentication_api/views/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNav(); // Navigate to BottomNav if user is logged in
          } else {
            return const LoginOrRegisterPage(); // Show LoginPage if user is not logged in
          }
        },
      ),
    );
  }
}
