import 'package:flutter/material.dart';

class Body {
  final Offset? nose;
  final BodySide left;
  final BodySide right;
  final Face face;
  final Hands hands;
  final Feet feet;

  Body({
    required this.nose,
    required this.left,
    required this.right,
    required this.face,
    required this.hands,
    required this.feet,
  });
}

class BodySide {
  final Offset? shoulder;
  final Offset? elbow;
  final Offset? wrist;
  final Offset? hip;
  final Offset? knee;
  final Offset? ankle;

  BodySide({
    required this.shoulder,
    required this.elbow,
    required this.wrist,
    required this.hip,
    required this.knee,
    required this.ankle,
  });
}

class Face {
  final Offset? leftEye;
  final Offset? rightEye;
  final Offset? leftEar;
  final Offset? rightEar;
  final Offset? mouthLeft;
  final Offset? mouthRight;

  Face({
    required this.leftEye,
    required this.rightEye,
    required this.leftEar,
    required this.rightEar,
    required this.mouthLeft,
    required this.mouthRight,
  });
}

class Hands {
  final Hand left;
  final Hand right;

  Hands({required this.left, required this.right});
}

class Hand {
  final Offset? thumb;
  final Offset? index;
  final Offset? pinky;

  Hand({required this.thumb, required this.index, required this.pinky});
}

class Feet {
  final Foot left;
  final Foot right;

  Feet({required this.left, required this.right});
}

class Foot {
  final Offset? heel;
  final Offset? index;

  Foot({required this.heel, required this.index});
}
