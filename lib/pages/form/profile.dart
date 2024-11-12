import 'package:flutter/material.dart';
import 'package:FlujoMX/entity/profile.dart';
import 'package:FlujoMX/enums.dart';
import 'package:email_validator/email_validator.dart';

class ProfileForm extends StatelessWidget {
  final _nameField = TextEditingController();
  final _emailField = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void onSubmit() async {
      if (_formKey.currentState!.validate()) {
        final user = Profile(
            email: _emailField.text,
            name: _nameField.text,
            currentFee: Fee.DOM_RURAL);
        Navigator.pop(context, user);
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Nuevo usuario"), centerTitle: true),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: _nameField,
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
                      controller: _emailField,
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : 'Introduce una direccion de correo valida',
                      decoration: const InputDecoration(
                          helperText: "Introduce un correo de contacto",
                          hintText: "example@example",
                          labelText: "Correo electronico",
                          border: OutlineInputBorder())),
                  const Spacer(),
                  FilledButton(onPressed: onSubmit, child: const Text("Crear"))
                ]))));
  }
}
