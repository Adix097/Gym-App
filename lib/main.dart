import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'pages/landing.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/dashboard.dart';
import 'services/auth_storage.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final loggedIn = await AuthStorage.isLoggedIn();
  runApp(GymApp(startRoute: loggedIn ? "/dashboard" : "/landing"));
}

class GymApp extends StatelessWidget {
  final String startRoute;

  const GymApp({super.key, required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: startRoute,
      routes: {
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
