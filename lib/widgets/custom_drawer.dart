import 'package:authentication_api/views/contact_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:authentication_api/services/image_service.dart';
import 'dart:io';
import 'package:authentication_api/views/about_us_screen.dart';
import 'package:authentication_api/views/help_screen.dart';
import 'package:authentication_api/views/setting_screen.dart';
import 'package:authentication_api/views/login_or_register.dart';
import 'package:authentication_api/generated/l10n.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  final ImageService _imageService = ImageService();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final image = await _imageService.getProfileImage();
    if (image != null && mounted) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage('assets/default_avatar.png')
                          as ImageProvider,
                ),
                TextButton(
                  onPressed: () => _showImageOptions(context),
                  child: Text(AppLocalizations.of(context).translate('editProfilePicture')),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('contacts')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactListScreen()));
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('aboutUs')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen())
              );
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('help')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpScreen())
              );
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('settings')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen())
              );
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context).translate('signOut')),
            onTap: () {
              // Implement sign out functionality
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginOrRegisterPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppLocalizations.of(context).translate('selectFromGallery')),
              onTap: () {
                _imageService.pickImageFromGallery().then((image) {
                  if (image != null) {
                    setState(() {
                      _profileImage = image;
                    });
                  }
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppLocalizations.of(context).translate('takePicture')),
              onTap: () {
                _imageService.takePicture().then((image) {
                  if (image != null) {
                    setState(() {
                      _profileImage = image;
                    });
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
