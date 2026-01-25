import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final Color backgroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textSize = 16,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.borderWidth,
    this.borderColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: (borderWidth != null && borderColor != null)
              ? BorderSide(color: borderColor!, width: borderWidth!)
              : BorderSide.none,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
