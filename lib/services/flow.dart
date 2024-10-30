import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:FlujoMX/database.dart' as db;
import 'package:FlujoMX/entity/flow.dart';
import 'package:sqflite/sqflite.dart';

final client = MqttServerClient.withPort("10.0.2.2", "client-1", 1883);

Future<void> initServices() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
        autoStart: true,
        isForegroundMode: false,
        autoStartOnBoot: true,
        onStart: startService),
    iosConfiguration: IosConfiguration(),
  );
  return;
}

@pragma("vm:entry-point")
Future<void> startService(ServiceInstance service) async {
  final _database = await db.getInstance();
  client.keepAlivePeriod = 20;
  var status = await client.connect();

  client.subscribe("flow/add", MqttQos.atMostOnce);

  client.published!.listen((MqttPublishMessage message) {
    final msg =
        MqttPublishPayload.bytesToStringAsString(message.payload.message);
    final flow = Flow(value: double.parse(msg), timestamp: DateTime.now());
    _database.insert("flow", flow.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  });
  service.on("stop").listen((ev) => print("on stop"));
  service.on("start").listen((ev) => print("on start"));
  return;
}
