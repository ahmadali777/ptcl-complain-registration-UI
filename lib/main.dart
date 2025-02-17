import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/main_nav_screen.dart';
import 'package:ptcl_app/HomeScreen/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestNotificationPermission();
  await initNotifications(); 
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PTCL Complain App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(206, 13, 231, 53)),
        useMaterial3: true,
      ),
      home:const MainScreen(),
    );
  }
}



