import 'package:FlujoMX/database.dart';
import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/enums.dart';

class ProfileRepo extends Repository {
  @override
  String get TABLE => "profile";

  @override
  Profile fromMap(Map<String, Object?> data) {
    return Profile(
        rowId: data['row_id'] as int,
        name: data['name'] as String,
        email: data['email'] as String,
        currentFee: Fee.values.elementAt(data['currentFee'] as int));
  }
}
