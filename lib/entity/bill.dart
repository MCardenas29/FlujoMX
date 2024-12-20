import 'package:FlujoMX/enums.dart';
import 'package:FlujoMX/entity/profile.dart';

class Bill {
  Profile owner;
  Fee fee;
  DateTime startDate;
  DateTime endDate;
  double total;
  double usage;
  List<Fee>? usages;

  Bill(
      {required this.owner,
      required this.fee,
      required this.startDate,
      required this.endDate,
      required this.total,
      required this.usage});
}
