import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part '../generated/provider/preferences.g.dart';

@Riverpod(dependencies: [])
SharedPreferencesAsync sharedPreferences(Ref ref) {
  final prefs = SharedPreferencesAsync();
  return prefs;
}

@Riverpod(dependencies: [sharedPreferences])
Future<bool> appFirstTime(Ref ref) async {
  final prefs = ref.read(sharedPreferencesProvider);
  return await prefs.getBool('first_time') ?? false;
}
