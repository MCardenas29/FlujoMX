import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/enums.dart';

class Profile extends Entity {
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
}
