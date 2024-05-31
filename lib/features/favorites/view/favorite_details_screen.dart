import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/favorites/bloc/favorites_bloc.dart';

class FavoriteDetailsScreen extends StatelessWidget {
  const FavoriteDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final coffee = context.select(
      (FavoritesBloc bloc) => bloc.state.coffees.firstWhere(
        (coffee) => coffee.id.toString() == id,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: InteractiveViewer(
        child: SizedBox.expand(
          child: Hero(
            tag: coffee.url,
            child: Image.memory(
              coffee.image,
            ),
          ),
        ),
      ),
    );
  }
}
