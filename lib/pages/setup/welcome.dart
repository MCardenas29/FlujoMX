import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/pages/main/index.dart';
import 'package:FlujoMX/pages/main/layout.dart';
import 'package:FlujoMX/repository/profile_repo.dart';
import 'package:FlujoMX/pages/form/profile.dart';
import 'package:FlujoMX/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupWelcomePage extends StatefulWidget {
  const SetupWelcomePage({super.key});

  @override
  State<StatefulWidget> createState() => _SetupWelcomePageState();
}

class _SetupWelcomePageState extends State {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  final ProfileRepo _profileRepo = ProfileRepo();
  Profile? _profile;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final router = GoRouter.of(context);
    final theme = Theme.of(context);

    void setupApp() async {
      Profile? result = await navigator
          .push(MaterialPageRoute(builder: (ctx) => ProfileForm()));
      if (result == null) return;
      result = await _profileRepo.save(result);
      setState(() => _profile = result);
      if (result.id == 0) throw ("Error al crear el usuario");
      await _preferences.setInt('current_profile', result.id!);
      await _preferences.setBool('first_time', false);
      router.push(MainIndex.route);
    }

    return _profile == null
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
        : const Loading();
  }
}
