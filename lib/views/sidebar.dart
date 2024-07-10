import 'package:authentication_api/views/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  title: Text(sideMenuData['title']),
                  trailing: sideMenuData['trailing'],
                  onTap: () async {
                    if (sideMenuData['action_id'] == 4) {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    }
                    // Add more actions here if needed
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
