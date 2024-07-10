import 'package:authentication_api/views/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authentication_api/views/sidebar.dart';
// ignore: library_prefixes
import 'package:authentication_api/screens/home_screen.dart' as CalculatorHomeScreen;
class HomeNavScreen extends StatelessWidget {
  HomeNavScreen({super.key});

  final User user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreen(),
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () => signUserOut(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Calculator app
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CalculatorHomeScreen.HomeScreen(), 
                  ),
                );
              },
              child: const Text('Go to Calculator'),
            ),
            ElevatedButton(
              onPressed: () => signUserOut(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
