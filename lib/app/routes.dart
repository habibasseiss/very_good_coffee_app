import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/features/home/home.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<FavoritesRoute>(
      path: 'favorites',
      routes: [
        TypedGoRoute<FavoriteDetailsRoute>(
          path: ':id',
        ),
      ],
    ),
  ],
)
@immutable
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@immutable
class FavoritesRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoritesScreen();
  }
}

@immutable
class FavoriteDetailsRoute extends GoRouteData {
  const FavoriteDetailsRoute({
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FavoriteDetailsScreen(id: id);
  }
}
