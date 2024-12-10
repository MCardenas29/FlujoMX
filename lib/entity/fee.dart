import 'package:FlujoMX/enums.dart';

// The matrix number are in the following order:
//    max, water, sewerage, sanitation.
// They came from a document of water usage
// TODO: Find a better way to achieve this
final Map<Fee, List<Range>> fees = {
  Fee.domB: Range.ranges([
    [15, 4.573, 1.143, 0.686],
    [30, 0.171, 0.043, 0.026],
    [50, 0.195, 0.049, 0.029],
    [75, 0.219, 0.055, 0.033],
    [100, 0.435, 0.109, 0.065],
    [double.infinity, 0.468, 0.117, 0.070]
  ]),
  Fee.domA: Range.ranges([
    [15, 2.342, 0.590, 0.351],
    [30, 0.085, 0.022, 0.013],
    [50, 0.095, 0.024, 0.015],
    [75, 0.107, 0.027, 0.017],
    [100, 0.228, 0.060, 0.036],
    [double.infinity, 0.457, 0.117, 0.070]
  ]),
  Fee.domRural: Range.ranges([
    [30, 1.993, 0.498, 0.299],
    [50, 0.068, 0.017, 0.010],
    [50, 0.068, 0.017, 0.010],
    [75, 0.071, 0.018, 0.010],
    [100, 0.074, 0.019, 0.011],
    [double.infinity, 0.161, 0.040, 0.023]
  ]),
};

class Range {
  double maxUsage;
  double waterCost;
  double sewerageCost;
  double sanitationCost;

  Range(
      {required this.maxUsage,
      required this.waterCost,
      required this.sewerageCost,
      required this.sanitationCost});
  Range._row(
      this.maxUsage, this.waterCost, this.sewerageCost, this.sanitationCost);
  factory Range.fromList(List<double> values) {
    if (values.length < 4) throw Exception('No enough values in the list');
    return Range._row(values[0], values[1], values[2], values[3]);
  }

  static ranges(List<List<double>> table) =>
      [for (var row in table) Range.fromList(row)];

  double get total => waterCost + sewerageCost + sanitationCost;
  double get cost => total * maxUsage;
  bool inRange(double currentUsage) => maxUsage < currentUsage;
}
