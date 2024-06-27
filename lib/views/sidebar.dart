import 'package:flutter/material.dart';
import 'package:calculator_app/views/about_us_screen.dart';
import 'package:calculator_app/views/bottom_nav.dart';
import 'package:calculator_app/views/help_screen.dart';
import 'package:calculator_app/views/setting_screen.dart';

class SideBarScreen extends StatelessWidget {
  const SideBarScreen({super.key});

  final List drawerMenuListname = const [
    {
      "leading": Icon(
        Icons.animation_rounded,
        color: Color(0xFF13C0E3),
      ),
      "title": "About Us",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 1,
    },
    {
      "leading": Icon(
        Icons.help,
        color: Color(0xFF13C0E3),
      ),
      "title": "Help",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 2,
    },
    {
      "leading": Icon(
        Icons.settings,
        color: Color(0xFF13C0E3),
      ),
      "title": "Settings",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 3,
    },
    {
      "leading": Icon(
        Icons.exit_to_app,
        color: Color(0xFF13C0E3),
      ),
      "title": "Log Out",
      "trailing": Icon(Icons.chevron_right),
      "action_id": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            children: [
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://www.channelfutures.com/files/2019/10/Focus-877x432.jpg"),
                ),
                title: Text(
                  "Regis M",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "regis@gmail.com",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    sideMenuData['title'],
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    
                    switch (sideMenuData['action_id']) {
                      case 1:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AboutUsScreen(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HelpScreen(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingScreen(),
                          ),
                        );
                        break;
                      case 4:
                        // Handle logout
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Logout"),
                              content: const Text("Are you sure you want to logout?"),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Logout"),
                                  onPressed: () {
                                    // Implement logout functionality here
                                    // For example, clear user data or authentication tokens

                                    // Close the dialog
                                    Navigator.of(context).pop();

                                    // Navigate to the home page (root of the app)
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const BottomNav(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        break;
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}