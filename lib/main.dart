import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:FlujoMX/screens/setup.dart';
import 'package:FlujoMX/screens/app.dart';
import 'package:flutter/material.dart';

SharedPreferencesAsync preferences = SharedPreferencesAsync();
FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final id = await preferences.getInt('user_id');

  runApp(id == null ? const SetupScreen() : App(uid: id));
}
