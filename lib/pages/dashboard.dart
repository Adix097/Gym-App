import "package:flutter/material.dart";
import 'package:gym_app_flutter/widgets/exercise_widget.dart';
import '../main.dart';

import '../data/exercise_data.dart';

import '../pages/exercise.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 18,
                decoration: TextDecoration.underline,
                decorationThickness: 1.5,
                decorationColor: Colors.teal,
              ),
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
