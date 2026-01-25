import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFrame extends StatelessWidget {
  final CameraController controller;
  final Offset? nosePosition;
  final Size? imageSize;
  final CameraDescription currentCamera;

  const CameraFrame({
    super.key,
    required this.controller,
    this.nosePosition,
    this.imageSize,
    required this.currentCamera,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double scale = 1.0;
        double offsetX = 0;
        double offsetY = 0;

        if (imageSize != null) {
          final screenAspectRatio =
              constraints.maxWidth / constraints.maxHeight;
          final imageAspectRatio = imageSize!.width / imageSize!.height;

          if (screenAspectRatio > imageAspectRatio) {
            scale = constraints.maxHeight / imageSize!.height;
            offsetX = (constraints.maxWidth - imageSize!.width * scale) / 2;
          } else {
            scale = constraints.maxWidth / imageSize!.width;
            offsetY = (constraints.maxHeight - imageSize!.height * scale) / 2;
          }
        }

        return Stack(
          children: [
            CameraPreview(controller),
            if (nosePosition != null && imageSize != null)
              Positioned(
                left:
                    offsetX +
                    (currentCamera.lensDirection == CameraLensDirection.front
                        ? (imageSize!.width - nosePosition!.dx) * scale
                        : nosePosition!.dx * scale),
                top: offsetY + nosePosition!.dy * scale,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
