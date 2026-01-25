import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../models/exercise_config.dart';

import '../../widgets/camera_frame.dart';
import '../../widgets/exercise_status.dart';

import '../../services/camera_services.dart';

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
  Offset? nosePosition;
  Size? imageSize;

  int target = 0;
  int count = 5;
  String status = "Tracking";

  @override
  void initState() {
    super.initState();

    cameraService = CameraService(cameras: widget.cameras);

    // Set up callback for nose detection
    cameraService.onPoseDetected = (Offset nose, Size imageSize) {
      target = widget.exercise.target;

      setState(() {
        nosePosition = nose;
        this.imageSize = imageSize;
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
                  nosePosition: nosePosition,
                  imageSize: imageSize,
                  currentCamera: cameraService.currentCamera,
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
