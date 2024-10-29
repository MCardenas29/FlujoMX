import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final client = MqttServerClient.withPort("10.0.2.2", "", 1883);

Future<void> initServices() async {
  final service = FlutterBackgroundService();
  var configured = await service.configure(
    androidConfiguration: AndroidConfiguration(
        autoStart: true,
        isForegroundMode: false,
        autoStartOnBoot: true,
        onStart: startService),
    iosConfiguration: IosConfiguration(),
  );
  print(configured ? "Configurado" : "No configurado");
  return;
}

@pragma("vm:entry-point")
Future<void> startService(ServiceInstance service) async {
  print("Pepe");
  print("Pepo");
  var status = await client.connect();
  print("Pepa");

  client.subscribe("flow/add", MqttQos.atMostOnce);
  client.published!.listen((MqttPublishMessage message) {
    print(message.payload.message.toString());
  });
  service.on("stop").listen((ev) => print("on stop"));
  service.on("start").listen((ev) => print("on start"));
  return;
}
