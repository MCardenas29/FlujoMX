class Flow {
  final int id;
  final DateTime timestamp;
  final double value;

  const Flow({required this.id, required this.timestamp, required this.value});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'value': value
    };
  }

  @override
  String toString() {
    return "Flow {id: $id, value: $value, timestamp: $timestamp}";
  }
}
