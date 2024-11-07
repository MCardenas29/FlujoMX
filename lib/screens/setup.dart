import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/repository/profile_repo.dart';
import 'package:FlujoMX/screens/form/profile.dart';
import 'package:FlujoMX/screens/index.dart';
import 'package:FlujoMX/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeSetup extends StatefulWidget {
  const WelcomeSetup({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeSetupState();
}

class _WelcomeSetupState extends State {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  final ProfileRepo _profileRepo = ProfileRepo();
  Profile? _profile;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final navigator = Navigator.of(context);
    final theme = Theme.of(context);

    void setupApp() async {
      final result = await navigator
          .push(MaterialPageRoute(builder: (ctx) => ProfileForm()));
      if (result == null) return;
      setState(() => _profile = result);
      int id = await _profileRepo.save(result);
      await _preferences.setInt('current_profile', id);
      await _preferences.setBool('first_time', false);
      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const Index()),
          (Route<dynamic> route) => false);
    }

    return Scaffold(
        body: _profile == null
            ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Bienvenido a"),
                          Text("FlujoMx",
                              style: theme.textTheme.displaySmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: SvgPicture.asset("assets/flujo-logo.svg")),
                        ])),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Center(
                        child: FilledButton(
                            onPressed: setupApp, child: const Text("Empezar"))))
              ])
            : const Loading());
  }
}
