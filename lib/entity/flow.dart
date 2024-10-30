class Flow {
  final DateTime timestamp;
  final double value;

  const Flow({required this.timestamp, required this.value});

  Map<String, Object?> toMap() {
    return {'timestamp': timestamp.millisecondsSinceEpoch, 'value': value};
  }

  @override
  String toString() {
    return "Flow {value: $value, timestamp: $timestamp}";
  }
}
