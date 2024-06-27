import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Help Screen"),
      ),
      body: const Center(
        child: Text('HELP SCREEN'),
      ),
    );
  }
}