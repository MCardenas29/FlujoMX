import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'services/flow.dart';
import 'util.dart';
import 'theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = 'mx.ucol.flujomx.waterflow';
const notificationId = 899;

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const MyApp());
  notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
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
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: BarChart(BarChartData(barGroups: [
            BarChartGroupData(
                x: 0, barRods: [BarChartRodData(toY: 2, color: Colors.red)]),
            BarChartGroupData(
                x: 1, barRods: [BarChartRodData(toY: 2, color: Colors.green)])
          ]))),
    );
  }
}
