import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:workmanager/workmanager.dart';
import 'util.dart';
import 'theme.dart';
import 'dart:developer';

@pragma("vm:entry-point")
void dispatcherCallback() {
  Workmanager().executeTask((task, inputData) async {
    log("Dispatcher callback");
    return Future.value(true);
  });
}

void main() {
  Workmanager().initialize(dispatcherCallback, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "mx.ucol.flujomx.flow_update",
    "update_flow",
    frequency: const Duration(seconds: 5),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Amaranth", "Alef");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'FlujoMX',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const MyHomePage(title: 'Flujo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          height: 300,
          child: BarChart(BarChartData(barGroups: [
            BarChartGroupData(
                x: 0, barRods: [BarChartRodData(toY: 2, color: Colors.red)]),
            BarChartGroupData(
                x: 1, barRods: [BarChartRodData(toY: 2, color: Colors.green)])
          ]))),
    );
  }
}
