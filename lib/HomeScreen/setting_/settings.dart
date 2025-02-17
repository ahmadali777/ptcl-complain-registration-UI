import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/setting_/feedback.dart';
import 'package:ptcl_app/HomeScreen/setting_/nearby_location.dart';
import 'package:ptcl_app/HomeScreen/setting_/profile_setting.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateTo(context, const ProfileSettingScreen());
              },
              child: const Text('Profile Setting'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateTo(context, const FeedbackScreen());
              },
              child: const Text('Feedback'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateTo(context, const NearbyOfficeLocatorScreen());
              },
              child: const Text('Nearby Office Locator'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform logout operation
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logged out')),
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}






