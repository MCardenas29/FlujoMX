import 'package:FlujoMX/pages/main/index.dart';
import 'package:FlujoMX/pages/main/layout.dart';
import 'package:FlujoMX/pages/main/notifications.dart';
import 'package:FlujoMX/pages/main/usage/daily.dart';
import 'package:FlujoMX/pages/setup/layout.dart';
import 'package:FlujoMX/repository/profile_repo.dart';
import 'package:FlujoMX/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesAsync preferences = SharedPreferencesAsync();
  final isFirstTime = await preferences.getBool('first_time') ?? true;
  runApp(App(doSetup: isFirstTime));
}

class App extends StatelessWidget {
  App({super.key, required this.doSetup});
  bool doSetup = true;
  final _routerKey = GlobalKey<NavigatorState>(debugLabel: 'main');
  final ProfileRepo profileRepo = ProfileRepo();

  get _router => GoRouter(
          initialLocation: doSetup ? '/_setup' : '/index',
          navigatorKey: _routerKey,
          redirect: (BuildContext ctx, GoRouterState state) async {
            return null;
          },
          routes: [
            // Setup page, this is only invoked when the app is firstly installed
            GoRoute(
                path: '/_setup',
                builder: (BuildContext ctx, GoRouterState state) =>
                    const SetupLayout()),
            // Main page router
            StatefulShellRoute.indexedStack(
                builder: (BuildContext context, GoRouterState state,
                        StatefulNavigationShell navShell) =>
                    MainLayout(navigationShell: navShell),
                branches: [
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: MainIndex.route,
                        builder: (BuildContext ctx, GoRouterState state) =>
                            const MainIndex())
                  ]),
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: MainUsageDaily.route,
                        builder: (BuildContext ctx, GoRouterState state) =>
                            const MainUsageDaily()),
                  ]),
                  StatefulShellBranch(routes: [
                    GoRoute(
                        path: MainNotifications.route,
                        builder: (BuildContext ctx, GoRouterState state) =>
                            const MainNotifications())
                  ])
                ]),
          ]);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp.router(
        title: "FlujoMx", theme: getTheme(context), routerConfig: _router);
  }
}
