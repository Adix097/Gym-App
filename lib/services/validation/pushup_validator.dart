import 'exercise_validator.dart';

class PushUpValidator extends ExerciseValidator {
  int reps = 0;
  String state = "up";

  static const double downAngle = 90;
  static const double upAngle = 160;
  static const double backStraightThreshold = 165;

  @override
  Map<String, dynamic> update(PoseLandmarks lm, double timestamp) {
    if (!lm.has(["shoulder", "elbow", "wrist", "hip", "foot"])) {
      return {};
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
    };
  }
}
