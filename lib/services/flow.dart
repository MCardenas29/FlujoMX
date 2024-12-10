import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const channelId = "flowmx_usage";
// const notificationId = 889;

// final client = MqttServerClient.withPort("10.0.2.2", "client-1", 1883);
// const notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(channelId, "Flujo",
//         icon: '@mipmap/ic_launcher',
//         ongoing: true,
//         playSound: false,
//         autoCancel: false,
//         silent: true));

Future<bool> initServices() async {
  final service = FlutterBackgroundService();
  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     channelId, 'Flujo',
  //     description: "Notificaciones del flujo actual",
  //     importance: Importance.low);
  return await service.configure(
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      isForegroundMode: false,
      autoStartOnBoot: true,
      onStart: startService,
      // notificationChannelId: channelId,
      // initialNotificationTitle: "Flujo",
      // foregroundServiceNotificationId: notificationId
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma("vm:entry-point")
Future<void> startService(ServiceInstance service) async {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   // final database = await db.getInstance();
//   client.keepAlivePeriod = 20;
//   var status = await client.connect();

//   client.subscribe("flow/add", MqttQos.atMostOnce);

//   client.published!.listen((MqttPublishMessage message) {
//     service.invoke("test");
//     final msg =
//         MqttPublishPayload.bytesToStringAsString(message.payload.message);
//     // final flow = Flow(value: double.parse(msg), timestamp: DateTime.now());
//     //  database.insert("flow", flow.toMap(),
//     //      conflictAlgorithm: ConflictAlgorithm.replace);
//     // notificationsPlugin.show(
//     //    notificationId, "Test", flow.value.toString(), notificationDetails);
//   });
}
