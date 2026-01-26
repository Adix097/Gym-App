import 'exercise_validator.dart';

class PlankValidator extends ExerciseValidator {
  double totalHoldTime = 0;
  double? startTime;
  bool holding = false;

  static const double backStraightThreshold = 165;

  @override
  Map<String, dynamic> update(PoseLandmarks lm, double timestamp) {
    if (!lm.has(["shoulder", "hip", "foot"])) {
      return {};
    }

    final backAngle = calculateAngle(lm["shoulder"], lm["hip"], lm["foot"]);

    final backStraight = backAngle > backStraightThreshold;

    if (backStraight) {
      if (!holding) {
        startTime = timestamp;
        holding = true;
      }
    } else {
      if (holding) {
        totalHoldTime += timestamp - startTime!;
        holding = false;
      }
    }

    final currentTime = holding
        ? totalHoldTime + (timestamp - startTime!)
        : totalHoldTime;

    return {
      "holdTime": currentTime,
      "backStraight": backStraight,
      "backAngle": backAngle,
    };
  }
}
