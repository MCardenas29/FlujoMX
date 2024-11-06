import 'package:FlujoMX/screens/form/user.dart';
import 'package:flutter/material.dart';
import 'package:FlujoMX/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(theme: getTheme(context), home: _WelcomeSetup());
  }
}

class _WelcomeSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void setupApp() async {
      final user = await Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => UserForm()));
    }

    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
    ]));
  }
}
