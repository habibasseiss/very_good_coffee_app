import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

/// {@template favorites_screen}
/// A screen that displays a list of favorited coffees.
/// {@endtemplate}
class FavoritesScreen extends StatelessWidget {
  /// {@macro favorites_screen}
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    context.read<FavoritesBloc>().add(const LoadFavoritesEvent());

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

          if (state.coffees.isEmpty) {
            return Center(
              child: Text(
                l10n.youHaveNoFavoritesYet,
                textAlign: TextAlign.center,
              ),
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
              child: Hero(
                tag: state.coffees[index].url,
                child: Image.memory(
                  state.coffees[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
