import 'package:flutter/material.dart';
import 'package:FlujoMX/util.dart';

class App extends StatelessWidget {
  final int uid;

  const App({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlujoMX', theme: getTheme(context), home: const Center());
  }
}
