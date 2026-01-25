import 'package:flutter/material.dart';
import '../models/body_models.dart';

class SkeletonOverlay extends StatelessWidget {
  final Body body;
  final Size imageSize; // camera image size (width, height)
  final bool isFrontCamera;

  const SkeletonOverlay({
    super.key,
    required this.body,
    required this.imageSize,
    this.isFrontCamera = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SkeletonPainter(
        body: body,
        imageSize: imageSize,
        isFrontCamera: isFrontCamera,
      ),
      size: Size.infinite,
    );
  }
}

class SkeletonPainter extends CustomPainter {
  final Body body;
  final Size imageSize;
  final bool isFrontCamera;

  SkeletonPainter({
    required this.body,
    required this.imageSize,
    required this.isFrontCamera,
  });

  Offset? _transformPoint(Offset? point, Size canvasSize) {
    if (point == null) return null;

    // Scale points from camera image size → canvas size
    double scaleX = canvasSize.width / imageSize.width;
    double scaleY = canvasSize.height / imageSize.height;

    double x = point.dx * scaleX;
    double y = point.dy * scaleY;

    // Mirror front camera
    if (isFrontCamera) x = canvasSize.width - x;

    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.lightBlueAccent
          .withAlpha((0.6 * 255).toInt()) // fixed deprecation
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // All body connections
    final connections = [
      [
        _transformPoint(body.nose, size),
        _transformPoint(body.face.leftEye, size),
      ],
      [
        _transformPoint(body.nose, size),
        _transformPoint(body.face.rightEye, size),
      ],
      [
        _transformPoint(body.face.leftEye, size),
        _transformPoint(body.face.leftEar, size),
      ],
      [
        _transformPoint(body.face.rightEye, size),
        _transformPoint(body.face.rightEar, size),
      ],
      [
        _transformPoint(body.left.shoulder, size),
        _transformPoint(body.right.shoulder, size),
      ],
      [
        _transformPoint(body.left.shoulder, size),
        _transformPoint(body.left.elbow, size),
      ],
      [
        _transformPoint(body.left.elbow, size),
        _transformPoint(body.left.wrist, size),
      ],
      [
        _transformPoint(body.right.shoulder, size),
        _transformPoint(body.right.elbow, size),
      ],
      [
        _transformPoint(body.right.elbow, size),
        _transformPoint(body.right.wrist, size),
      ],
      [
        _transformPoint(body.left.shoulder, size),
        _transformPoint(body.left.hip, size),
      ],
      [
        _transformPoint(body.right.shoulder, size),
        _transformPoint(body.right.hip, size),
      ],
      [
        _transformPoint(body.left.hip, size),
        _transformPoint(body.right.hip, size),
      ],
      [
        _transformPoint(body.left.hip, size),
        _transformPoint(body.left.knee, size),
      ],
      [
        _transformPoint(body.left.knee, size),
        _transformPoint(body.left.ankle, size),
      ],
      [
        _transformPoint(body.right.hip, size),
        _transformPoint(body.right.knee, size),
      ],
      [
        _transformPoint(body.right.knee, size),
        _transformPoint(body.right.ankle, size),
      ],
      // Hands
      [
        _transformPoint(body.left.wrist, size),
        _transformPoint(body.hands.left.thumb, size),
      ],
      [
        _transformPoint(body.left.wrist, size),
        _transformPoint(body.hands.left.index, size),
      ],
      [
        _transformPoint(body.left.wrist, size),
        _transformPoint(body.hands.left.pinky, size),
      ],
      [
        _transformPoint(body.right.wrist, size),
        _transformPoint(body.hands.right.thumb, size),
      ],
      [
        _transformPoint(body.right.wrist, size),
        _transformPoint(body.hands.right.index, size),
      ],
      [
        _transformPoint(body.right.wrist, size),
        _transformPoint(body.hands.right.pinky, size),
      ],
      // Feet
      [
        _transformPoint(body.left.ankle, size),
        _transformPoint(body.feet.left.heel, size),
      ],
      [
        _transformPoint(body.left.ankle, size),
        _transformPoint(body.feet.left.index, size),
      ],
      [
        _transformPoint(body.right.ankle, size),
        _transformPoint(body.feet.right.heel, size),
      ],
      [
        _transformPoint(body.right.ankle, size),
        _transformPoint(body.feet.right.index, size),
      ],
    ];

    for (final connection in connections) {
      final start = connection[0];
      final end = connection[1];
      if (start != null && end != null) {
        canvas.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
