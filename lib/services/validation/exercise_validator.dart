import 'dart:math';

/// Simple landmark wrapper
class PoseLandmarks {
  final Map<String, Point<double>> points;

  PoseLandmarks(this.points);

  bool has(List<String> keys) => keys.every((k) => points.containsKey(k));

  Point<double> operator [](String key) => points[key]!;
}

/// Shared angle calculation
double calculateAngle(Point a, Point b, Point c) {
  final ba = Point(a.x - b.x, a.y - b.y);
  final bc = Point(c.x - b.x, c.y - b.y);

  final dot = ba.x * bc.x + ba.y * bc.y;
  final magBA = sqrt(ba.x * ba.x + ba.y * ba.y);
  final magBC = sqrt(bc.x * bc.x + bc.y * bc.y);

  if (magBA == 0 || magBC == 0) return 0;

  double cosine = dot / (magBA * magBC);
  cosine = cosine.clamp(-1.0, 1.0);

  return acos(cosine) * 180 / pi;
}

/// Base validator
abstract class ExerciseValidator {
  Map<String, dynamic> update(PoseLandmarks landmarks, double timestamp);
}
