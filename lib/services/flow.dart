import 'package:flutter_background_service/flutter_background_service.dart';

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
void startService(ServiceInstance service) async {
  print("OnStart");
  service.on("stop").listen((ev) => print("on stop"));
  service.on("start").listen((ev) => print("on start"));
}
