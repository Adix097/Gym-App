import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../models/body_models.dart';

class CameraService {
  late CameraController controller;
  late PoseDetector poseDetector;
  late CameraDescription currentCamera;

  final List<CameraDescription> cameras;
  Function(Body, Size)? onBodyDetected;

  CameraService({required this.cameras});

  Future<void> initialize() async {
    try {
      if (cameras.isEmpty) {
        throw Exception('No cameras available on this device');
      }

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
    } catch (e) {
      throw Exception('Camera initialization failed: $e');
    }
  }

  // ---------- Process each frame ----------
  void processImage(CameraImage image) async {
    if (onBodyDetected == null) return;

    final inputImage = _convertCameraImage(image);
    final poses = await poseDetector.processImage(inputImage);
    if (poses.isEmpty) return;

    final landmarks = poses.first.landmarks;

    Offset? point(PoseLandmarkType type) {
      final lm = landmarks[type];
      return lm == null ? null : Offset(lm.x, lm.y);
    }

    final body = Body(
      nose: point(PoseLandmarkType.nose),
      left: BodySide(
        shoulder: point(PoseLandmarkType.leftShoulder),
        elbow: point(PoseLandmarkType.leftElbow),
        wrist: point(PoseLandmarkType.leftWrist),
        hip: point(PoseLandmarkType.leftHip),
        knee: point(PoseLandmarkType.leftKnee),
        ankle: point(PoseLandmarkType.leftAnkle),
      ),
      right: BodySide(
        shoulder: point(PoseLandmarkType.rightShoulder),
        elbow: point(PoseLandmarkType.rightElbow),
        wrist: point(PoseLandmarkType.rightWrist),
        hip: point(PoseLandmarkType.rightHip),
        knee: point(PoseLandmarkType.rightKnee),
        ankle: point(PoseLandmarkType.rightAnkle),
      ),
      face: Face(
        leftEye: point(PoseLandmarkType.leftEye),
        rightEye: point(PoseLandmarkType.rightEye),
        leftEar: point(PoseLandmarkType.leftEar),
        rightEar: point(PoseLandmarkType.rightEar),
        mouthLeft: point(PoseLandmarkType.leftMouth),
        mouthRight: point(PoseLandmarkType.rightMouth),
      ),
      hands: Hands(
        left: Hand(
          thumb: point(PoseLandmarkType.leftThumb),
          index: point(PoseLandmarkType.leftIndex),
          pinky: point(PoseLandmarkType.leftPinky),
        ),
        right: Hand(
          thumb: point(PoseLandmarkType.rightThumb),
          index: point(PoseLandmarkType.rightIndex),
          pinky: point(PoseLandmarkType.rightPinky),
        ),
      ),
      feet: Feet(
        left: Foot(
          heel: point(PoseLandmarkType.leftHeel),
          index: point(PoseLandmarkType.leftFootIndex),
        ),
        right: Foot(
          heel: point(PoseLandmarkType.rightHeel),
          index: point(PoseLandmarkType.rightFootIndex),
        ),
      ),
    );

    onBodyDetected?.call(body, Size(image.width.toDouble(), image.height.toDouble()));
  }

  // ---------- Camera image conversion ----------
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

  // ---------- Flip front/back camera ----------
  Future<void> flipCamera() async {
    try {
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
    } catch (e) {
      throw Exception('Camera flip failed: $e');
    }
  }

  void dispose() {
    controller.dispose();
    poseDetector.close();
  }
}