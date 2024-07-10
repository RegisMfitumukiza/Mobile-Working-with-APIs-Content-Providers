import 'package:authentication_api/views/home_screen.dart';
import 'package:authentication_api/views/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: library_prefixes
import 'package:authentication_api/screens/home_screen.dart' as CalculatorHomeScreen;

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  // Define the BottomNavigationBar items
  final List<BottomNavigationBarItem> _navBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calculate),
      label: 'Calculator',
    ),
  ];

  // Define the widget options
  static final List<Widget> _widgetOptions = <Widget>[
    HomeNavScreen(),
    const CalculatorHomeScreen.HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _navBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _signOut,
        backgroundColor: Colors.red,  // Sign out when the button is pressed
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}
