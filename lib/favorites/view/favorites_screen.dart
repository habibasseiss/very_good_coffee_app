import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

/// {@template favorites_screen}
/// A screen that displays a list of favorited coffees.
/// {@endtemplate}
class FavoritesScreen extends StatelessWidget {
  /// {@macro favorites_screen}
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: context.read(),
      )..add(const LoadFavoritesEvent()),
      child: const FavoritesView(),
    );
  }
}

/// {@template favorites_view}
/// Displays the Body of FavoritesView
/// {@endtemplate}
class FavoritesView extends StatelessWidget {
  /// {@macro favorites_view}
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favorites),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: state.coffees.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () =>
                  FavoriteDetailsRoute(id: state.coffees[index].id.toString())
                      .go(context),
              child: Image.memory(
                state.coffees[index].image!,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
