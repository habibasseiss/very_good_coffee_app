import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:very_good_coffee_app/app/providers/global_bloc_provider.dart';
import 'package:very_good_coffee_app/app/providers/global_repository_provider.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class App extends StatelessWidget {
  App({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: $appRoutes,
  );

  @override
  Widget build(BuildContext context) {
    return GlobalRepositoryProvider(
      child: GlobalBlocProvider(
        child: MaterialApp.router(
          theme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.brown,
            appBarTheme: const AppBarTheme(),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }
}
