import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/enums.dart';

final class Profile extends Entity {
  static const String TABLE = "profile";
  String name;
  String email;
  Fee currentFee;

  Profile(
      {super.rowId,
      required this.name,
      required this.email,
      required this.currentFee});

  @override
  Map<String, Object?> toMap() =>
      {"name": name, "email": email, "currentFee": currentFee.index};

  factory Profile.fromMap(Map<String, Object?> data) {
    return Profile(
        rowId: data['rowid'] as int,
        name: data['name'] as String,
        email: data['email'] as String,
        currentFee: Fee.values.elementAt(data['currentFee'] as int));
  }
}
