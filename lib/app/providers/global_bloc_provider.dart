import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';

/// {@template global_bloc_provider}
/// A provider widget that provides global blocs to the widget tree. It
/// instantiates [FavoritesBloc] so it can be shared by multiple screens.
/// {@endtemplate}
class GlobalBlocProvider extends StatelessWidget {
  /// {@macro global_bloc_provider}
  const GlobalBlocProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesRepository: context.read(),
          )..add(const LoadFavoritesEvent()),
        ),
      ],
      child: child,
    );
  }
}
