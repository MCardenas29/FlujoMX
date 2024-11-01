import 'package:FlujoMX/types.dart';

class Flow implements Entity {
  @override
  String get TABLE => "flow";
  DateTime timestamp;
  double value;

  Flow({required this.timestamp, required this.value});

  @override
  Map<String, Object?> toMap() {
    return {'timestamp': timestamp.millisecondsSinceEpoch, 'value': value};
  }

  @override
  String toString() {
    return "Flow {value: $value, timestamp: $timestamp}";
  }
}
