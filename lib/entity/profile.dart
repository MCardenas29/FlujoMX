import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/enums.dart';

final class Profile extends Entity {
  static const String TABLE = "profile";
  String name;
  String email;
  Fee currentFee;

  Profile(
      {super.id,
      required this.name,
      required this.email,
      required this.currentFee});

  @override
  Map<String, Object?> toMap() =>
      {"id": id, "name": name, "email": email, "currentFee": currentFee.index};

  Profile copyWith(
          {final int? id,
          final String? name,
          final String? email,
          final Fee? currentFee}) =>
      Profile(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          currentFee: currentFee ?? this.currentFee);

  factory Profile.fromMap(Map<String, Object?> data) {
    return Profile(
        id: data['id'] as int,
        name: data['name'] as String,
        email: data['email'] as String,
        currentFee: Fee.values.elementAt(data['currentFee'] as int));
  }

  @override
  String toString() {
    return "Profile {id: $id, name: $name, email: $email, fee: $currentFee}";
  }
}
