import 'package:FlujoMX/pages/main/index.dart';
import 'package:FlujoMX/pages/main/layout.dart';
import 'package:FlujoMX/pages/main/notifications.dart';
import 'package:FlujoMX/pages/main/usage/daily.dart';
import 'package:FlujoMX/pages/setup/layout.dart';
import 'package:FlujoMX/provider/database.dart';
import 'package:FlujoMX/provider/preferences.dart';
import 'package:FlujoMX/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDb();
  runApp(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)], child: App()));
}

class App extends ConsumerWidget {
  final _routerKey = GlobalKey<NavigatorState>(debugLabel: 'main');

  App({super.key});

  GoRouter _router(bool doSetup) => GoRouter(
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
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final firstTime = ref.read(appFirstTimeProvider).value;

    return MaterialApp.router(
        title: "FlujoMx",
        theme: getTheme(context),
        routerConfig: _router(firstTime ?? false));
  }
}
