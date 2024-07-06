import 'package:flutter/material.dart';
import 'package:calculator_app/views/sidebar.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreen(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
      ),
      body: const Center(
        child: Text('HOME SCREEN'),
      ),
    );
  }
}