import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/repository/profile_repo.dart';
import 'package:FlujoMX/screens/index.dart';
import 'package:FlujoMX/screens/loading.dart';
import 'package:FlujoMX/screens/setup.dart';
import 'package:FlujoMX/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  final ProfileRepo _profileRepo = ProfileRepo();

  App({super.key});

  Future<Profile?> getUser() async {
    final isFirstTime = await _preferences.getBool('first_time') ?? true;
    if (isFirstTime) return null;
    final profileId = await _preferences.getInt('current_profile') ?? 0;
    if (profileId == 0) return null;
    final user = await _profileRepo.fetch(profileId);
    print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlujoMX',
        theme: getTheme(context),
        home: FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot<Profile?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }
            if (snapshot.data == null) return const WelcomeSetup();
            return const Index();
          },
        ));
  }
}
