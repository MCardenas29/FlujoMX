import 'package:FlujoMX/entity/fee.dart';
import 'package:FlujoMX/enums.dart';
import 'package:FlujoMX/provider/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/provider/fee.g.dart';

@Riverpod(dependencies: [CurrentProfile])
Fee? currentFee(Ref ref) {
  final profile = ref.watch(currentProfileProvider);
  if (!profile.hasValue) return null;
  return profile.value?.fee;
}

@Riverpod(dependencies: [currentFee])
List<Range>? feePrice(Ref ref) {
  final fee = ref.watch(currentFeeProvider);
  return fees[fee];
}
