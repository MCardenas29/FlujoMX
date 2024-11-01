import 'package:FlujoMX/enums.dart';
import 'package:FlujoMX/types.dart';

class User implements Entity {
  @override
  String get TABLE => "user";
  String name;
  String email;
  Fee currentFee;

  User({required this.name, required this.email, required this.currentFee});

  @override
  Map<String, Object?> toMap() =>
      {"name": name, "email": email, "currentFee": currentFee.index};
}
