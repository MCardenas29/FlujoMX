import 'package:flutter/material.dart';
import 'package:FlujoMX/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:FlujoMX/database.dart' as db;

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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => _InfoSetup()));
                  },
                  child: const Text("Empezar"))))
    ]));
  }
}

class _InfoSetup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Informacion"), centerTitle: true),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 20),
                  TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Introduce un valor" : null,
                      decoration: const InputDecoration(
                          helperText:
                              "Introduce el nombre a utilizar en las facturas",
                          hintText: "Jhon Doe",
                          labelText: "Nombre",
                          border: OutlineInputBorder())),
                  const SizedBox(height: 20),
                  TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'Introduce una direccion de correo valida',
                      decoration: const InputDecoration(
                          helperText: "Introduce un correo de contacto",
                          hintText: "jhon.doe@example.xyz",
                          labelText: "Correo electronico",
                          border: OutlineInputBorder())),
                  const Spacer(),
                  FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final database = await db.getInstance();
                        }
                      },
                      child: const Text("Continuar"))
                ]))));
  }
}
