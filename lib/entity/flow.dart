import 'package:freezed_annotation/freezed_annotation.dart';
part '../generated/entity/flow.freezed.dart';
part '../generated/entity/flow.g.dart';

@freezed
class Flow with _$Flow {
  static const String TABLE = "flow";

  const factory Flow(
      {int? id, required DateTime timestamp, required double value}) = _Flow;

  factory Flow.fromJson(Map<String, Object?> json) => _$FlowFromJson(json);
}
