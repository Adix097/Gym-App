import 'exercise_validator.dart';

class PushUpValidator extends ExerciseValidator {
  int reps = 0;
  String state = "up";

  static const double downAngle = 90;
  static const double upAngle = 160;
  static const double backStraightThreshold = 165;
  static const double confidenceThreshold = 0.6;

  @override
  Map<String, dynamic> update(PoseLandmarks lm, double timestamp) {
    if (!lm.has(["shoulder", "elbow", "wrist", "hip", "foot"])) {
      return {};
    }

    // Check that all key landmarks have sufficient confidence
    if (!lm.hasAllConfidence(
      ["shoulder", "elbow", "wrist", "hip", "foot"],
      threshold: confidenceThreshold,
    )) {
      return {
        "reps": reps,
        "backStraight": false,
        "elbowAngle": 0.0,
        "backAngle": 0.0,
        "lowConfidence": true,
      };
    }

    final elbowAngle = calculateAngle(lm["shoulder"], lm["elbow"], lm["wrist"]);

    final backAngle = calculateAngle(lm["shoulder"], lm["hip"], lm["foot"]);

    final backStraight = backAngle > backStraightThreshold;

    if (elbowAngle < downAngle) {
      state = "down";
    }

    if (elbowAngle > upAngle && state == "down") {
      if (backStraight) reps++;
      state = "up";
    }

    return {
      "reps": reps,
      "backStraight": backStraight,
      "elbowAngle": elbowAngle,
      "backAngle": backAngle,
      "lowConfidence": false,
    };
  }
}
