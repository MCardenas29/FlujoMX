import 'package:FlujoMX/provider/mqtt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        appBar: AppBar(title: Text("Flujo"), centerTitle: true),
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Inicio",
            ),
            NavigationDestination(
              icon: Icon(Icons.query_stats),
              label: "Uso",
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: "Notificaciones",
            )
          ],
        ));
  }
}
