import 'package:flutter/material.dart';


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About Us Screen"),
      ),
      body: const Center(
        child: Text('ABOUT US SCREEN'),
      ),
    );
  }
}
