import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String placeholder;
  final Color placeholderColor;
  final bool filled;
  final Color backgroundColor;
  final double borderRadius;

  const InputField({
    super.key,
    required this.placeholder,
    this.placeholderColor = Colors.white,
    this.filled = true,
    this.backgroundColor = Colors.black,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: placeholderColor),
        filled: filled,
        fillColor: backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
