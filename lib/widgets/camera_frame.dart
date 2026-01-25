import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../models/body_models.dart';
import 'skeleton_overlay.dart';

class CameraFrame extends StatelessWidget {
  final CameraController controller;
  final Offset? nosePosition;
  final Size? imageSize;
  final CameraDescription currentCamera;
  final Body? body;

  const CameraFrame({
    super.key,
    required this.controller,
    this.nosePosition,
    this.imageSize,
    required this.currentCamera,
    this.body,
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

        int quarterTurns = 0;
        if (Platform.isAndroid) {
          quarterTurns = (4 - (currentCamera.sensorOrientation ~/ 90)) % 4;
        }
        bool isRotated = quarterTurns == 1 || quarterTurns == 3;

        if (imageSize != null) {
          final double imageWidth = isRotated ? imageSize!.height : imageSize!.width;
          final double imageHeight = isRotated ? imageSize!.width : imageSize!.height;

          final screenAspectRatio =
              constraints.maxWidth / constraints.maxHeight;
          final imageAspectRatio = imageWidth / imageHeight;

          if (screenAspectRatio > imageAspectRatio) {
            scale = constraints.maxHeight / imageHeight;
            offsetX = (constraints.maxWidth - imageWidth * scale) / 2;
          } else {
            scale = constraints.maxWidth / imageWidth;
            offsetY = (constraints.maxHeight - imageHeight * scale) / 2;
          }
        }

        List<Widget> children = [CameraPreview(controller)];

        if (body != null && imageSize != null) {
          children.add(
            Positioned(
              left: offsetX,
              top: offsetY,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: RotatedBox(
                  quarterTurns: quarterTurns,
                  child: SizedBox(
                    width: imageSize!.width,
                    height: imageSize!.height,
                    child: SkeletonOverlay(
                      body: body!,
                      imageSize: imageSize!,
                      isFrontCamera: currentCamera.lensDirection == CameraLensDirection.front,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Stack(children: children);
      },
    );
  }
}
