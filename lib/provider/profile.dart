import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/provider/preferences.dart';
import 'package:FlujoMX/repository/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/provider/profile.g.dart';

@Riverpod(dependencies: [sharedPreferences, profileRepository])
class CurrentProfile extends _$CurrentProfile {
  @override
  FutureOr<Profile?> build() async {
    final prefs = ref.read(sharedPreferencesProvider);
    final profileRepo = ref.read(profileRepositoryProvider);

    final userId = await prefs.getInt("current_profile") ?? 0;
    if (userId < 1) return null;
    return await profileRepo.fetch(userId);
  }

  Future<bool> changeProfile(Profile profile) async {
    state = const AsyncValue.loading();
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setInt("current_profile", profile.id!);
    state = AsyncValue.data(profile);
    return true;
  }

  Future<void> changeProfileId(int userId) async {
    state = const AsyncValue.loading();
    final prefs = ref.read(sharedPreferencesProvider);
    final profileRepo = ref.read(profileRepositoryProvider);
    final user = await profileRepo.fetch(userId);
    if (user == null) {
      state = AsyncValue.error("User does not exists", StackTrace.current);
      return;
    }

    prefs.setInt("current_profile", userId);
    state = AsyncValue.data(user);
  }
}
