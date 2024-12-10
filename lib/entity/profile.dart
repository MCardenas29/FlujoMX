import 'package:FlujoMX/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../generated/entity/profile.freezed.dart';
part '../generated/entity/profile.g.dart';

@freezed
class Profile with _$Profile {
  static const String TABLE = "profile";

  const Profile._();
  const factory Profile(
      {int? id,
      required String name,
      required String email,
      required int currentFee}) = _Profile;

  Fee get fee => Fee.values.elementAt(currentFee);

  factory Profile.fromJson(Map<String, Object?> json) =>
      _$ProfileFromJson(json);
}
