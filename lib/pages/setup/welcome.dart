import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/pages/main/index.dart';
import 'package:FlujoMX/pages/form/profile.dart';
import 'package:FlujoMX/components/loading.dart';
import 'package:FlujoMX/provider/preferences.dart';
import 'package:FlujoMX/provider/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SetupWelcomePage extends ConsumerWidget {
  const SetupWelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigator = Navigator.of(context);
    final router = GoRouter.of(context);
    final theme = Theme.of(context);
    final currentProfile = ref.watch(currentProfileProvider);
    final prefs = ref.read(sharedPreferencesProvider);

    void setupApp() async {
      Profile? result = await navigator
          .push(MaterialPageRoute(builder: (ctx) => ProfileForm()));
      if (result == null) return;
      ref.read(currentProfileProvider.notifier).changeProfile(result);
      await prefs.setBool('first_time', true);
      router.push(MainIndex.route);
    }

    return currentProfile.value == null
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
