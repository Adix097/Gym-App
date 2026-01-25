import "package:flutter/material.dart";
import 'package:gym_app_flutter/widgets/exercise_widget.dart';
import '../main.dart';
import '../data/exercise_data.dart';
import '../pages/exercise.dart';
import '../services/auth_storage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoggedIn = false;
  String? username;

  @override
  void initState() {
    super.initState();
    _loadAuthStatus();
  }

  Future<void> _loadAuthStatus() async {
    isLoggedIn = await AuthStorage.isLoggedIn();
    if (isLoggedIn) {
      username = await AuthStorage.getUsername();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Exercises'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          if (!isLoggedIn)
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color.fromARGB(255, 221, 217, 42),
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                  decorationColor: Color.fromARGB(255, 221, 217, 42),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 241, 80, 37),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    username ?? '',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 241, 80, 37),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: exercises.map((exercise) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ExercisePage(cameras: cameras, exercise: exercise),
                  ),
                );
              },
              child: ExerciseWidget(
                title: exercise.name,
                icon: Icons.fitness_center,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
