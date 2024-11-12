import 'package:FlujoMX/database.dart';

class Flow extends Entity {
  DateTime timestamp;
  double value;

  Flow({super.id, required this.timestamp, required this.value});

  @override
  Map<String, Object?> toMap() {
    return {'timestamp': timestamp.millisecondsSinceEpoch, 'value': value};
  }
}
