import 'package:flutter/material.dart';

class ExerciseStatus extends StatelessWidget {
  final int count;
  final int target;
  final String status;

  const ExerciseStatus({
    super.key,
    required this.count,
    required this.target,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  "Count",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "$count",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Target",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "$target",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "Status: $status",
              style: const TextStyle(fontSize: 18, color: Colors.greenAccent),
            ),
          ),
        ),
      ],
    );
  }
}
