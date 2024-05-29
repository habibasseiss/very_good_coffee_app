import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:very_good_coffee_app/app/home_screen.dart';
import 'package:very_good_coffee_app/favorites/favorite_details_screen.dart';
import 'package:very_good_coffee_app/favorites/favorites_screen.dart';

part 'routes.g.dart';

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
