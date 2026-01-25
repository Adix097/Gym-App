import 'package:flutter/material.dart';

class ExerciseWidget extends StatelessWidget {
  final Color? widgetColor;
  final double padding;
  final IconData icon;
  final Color iconColor;
  final String title;
  final double titleSize;
  final Color titleColor;

  const ExerciseWidget({
    super.key,
    required this.title,
    required this.icon,
    this.widgetColor,
    this.iconColor = Colors.white,
    this.padding = 20,
    this.titleColor = Colors.white,
    this.titleSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widgetColor ?? Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(fontSize: titleSize, color: titleColor),
            ),
          ],
        ),
      ),
    );
  }
}
