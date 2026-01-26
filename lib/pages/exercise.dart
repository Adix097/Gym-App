import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../models/exercise_config.dart';
import '../models/body_models.dart';
import '../../widgets/camera_frame.dart';
import '../../widgets/exercise_status.dart';
import '../services/camera_functions.dart';
import '../services/validation/exercise_validator.dart';
import '../services/validation/pushup_validator.dart';
import '../services/validation/plank_validator.dart';

class ExercisePage extends StatefulWidget {
  final Exercise exercise;

  final List<CameraDescription> cameras;

  const ExercisePage({
    super.key,
    required this.cameras,
    required this.exercise,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late CameraService cameraService;
  late Future<void> _cameraInitFuture;

  PoseLandmarks? _bodyToLandmarks(Body body) {
    final left = body.left;
    final right = body.right;

    bool leftOk =
        left.shoulder != null &&
        left.elbow != null &&
        left.wrist != null &&
        left.hip != null &&
        left.ankle != null;

    bool rightOk =
        right.shoulder != null &&
        right.elbow != null &&
        right.wrist != null &&
        right.hip != null &&
        right.ankle != null;

    if (!leftOk && !rightOk) return null;

    final side = leftOk ? left : right;

    return PoseLandmarks({
      "shoulder": Point(side.shoulder!.dx, side.shoulder!.dy),
      "elbow": Point(side.elbow!.dx, side.elbow!.dy),
      "wrist": Point(side.wrist!.dx, side.wrist!.dy),
      "hip": Point(side.hip!.dx, side.hip!.dy),
      "foot": Point(side.ankle!.dx, side.ankle!.dy),
    });
  }

  late ExerciseValidator validator;

  Size? imageSize;
  Body? body;

  int target = 0;
  int count = 0;
  String status = "Tracking";

  @override
  void initState() {
    super.initState();

    cameraService = CameraService(cameras: widget.cameras);
    target = widget.exercise.target;

    switch (widget.exercise.name.toLowerCase()) {
      case "pushup":
        validator = PushUpValidator();
        break;
      case "plank":
        validator = PlankValidator();
        break;
      default:
        throw Exception("No validator for this exercise");
    }

    // Set up callback for body detection
    cameraService.onBodyDetected = (Body body, Size imageSize) {
      final landmarks = _bodyToLandmarks(body);
      if (landmarks == null) return;

      final timestamp = DateTime.now().millisecondsSinceEpoch / 1000.0;

      final result = validator.update(landmarks, timestamp);

      setState(() {
        this.body = body;
        this.imageSize = imageSize;

        if (result.containsKey("reps")) {
          count = result["reps"];
        }

        if (result.containsKey("holdTime")) {
          count = result["holdTime"].round();
        }

        if (result.containsKey("backStraight")) {
          status = result["backStraight"] ? "Good Form" : "Fix Your Posture";
        }
      });
    };

    _cameraInitFuture = cameraService.initialize();
  }

  @override
  void dispose() {
    cameraService.dispose();
    super.dispose();
  }

  void onFlipCamera() {
    setState(() {
      _cameraInitFuture = cameraService.flipCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.exercise.name,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/dashboard',
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flip_camera_android),
            onPressed: onFlipCamera,
          ),
        ],
      ),

      body: FutureBuilder(
        future: _cameraInitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                flex: 4,
                child: CameraFrame(
                  controller: cameraService.controller,
                  imageSize: imageSize,
                  currentCamera: cameraService.currentCamera,
                  body: body,
                ),
              ),
              const SizedBox(height: 20),
              ExerciseStatus(count: count, target: target, status: status),
            ],
          );
        },
      ),
    );
  }
}
