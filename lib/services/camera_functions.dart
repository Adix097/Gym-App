import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class CameraService {
  late CameraController controller;
  late PoseDetector poseDetector;
  late CameraDescription currentCamera;

  final List<CameraDescription> cameras;
  Function(Offset, Size)? onPoseDetected;

  CameraService({required this.cameras});

  Future<void> initialize() async {
    currentCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      currentCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();

    poseDetector = PoseDetector(
      options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
    );

    await Future.delayed(const Duration(milliseconds: 300));

    controller.startImageStream(processImage);
  }

  // Process each frame for nose detection
  void processImage(CameraImage image) async {
    final inputImage = _convertCameraImage(image);
    final poses = await poseDetector.processImage(inputImage);

    if (poses.isNotEmpty) {
      final nose = poses.first.landmarks[PoseLandmarkType.nose];
      if (nose != null && onPoseDetected != null) {
        onPoseDetected!(
          Offset(nose.x, nose.y),
          Size(image.width.toDouble(), image.height.toDouble()),
        );
        print("Nose position: ${nose.x}, ${nose.y}");
      }
    }
  }

  InputImage _convertCameraImage(CameraImage image) {
    final bytesBuilder = BytesBuilder();
    for (final plane in image.planes) {
      bytesBuilder.add(plane.bytes);
    }

    final bytes = bytesBuilder.toBytes();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      ),
    );
  }

  // Flip front/back camera
  Future<void> flipCamera() async {
    final newLensDirection =
        currentCamera.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final newCamera = cameras.firstWhere(
      (c) => c.lensDirection == newLensDirection,
      orElse: () => cameras.first,
    );

    if (newCamera == currentCamera) return;

    await controller.stopImageStream();
    await controller.dispose();

    currentCamera = newCamera;

    controller = CameraController(
      currentCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller.initialize();

    await Future.delayed(const Duration(milliseconds: 300));

    controller.startImageStream(processImage);
  }

  void dispose() {
    controller.dispose();
    poseDetector.close();
  }
}
