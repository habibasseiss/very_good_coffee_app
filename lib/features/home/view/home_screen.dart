import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/routes/routes.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/features/home/home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

/// {@template home_screen}
/// A [StatelessWidget] which is responsible for providing a [HomeBloc]
/// to the [HomeView].
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            coffeeRepository: context.read(),
          )..add(const LoadRandomCoffeeEvent()),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(
            favoritesRepository: context.read(),
          )..add(const LoadFavoritesEvent()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

/// {@template home_view}
/// Displays the body of HomeView
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select((HomeBloc bloc) => bloc.state);
    final favoritesCount =
        context.select((FavoritesBloc bloc) => bloc.state.coffees.length);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: state is HomeLoading
              ? null
              : () => context.read<HomeBloc>().add(
                    const LoadRandomCoffeeEvent(),
                  ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: favoritesCount > 0,
              label: Text(favoritesCount.toString()),
              child: const Icon(Icons.list),
            ),
            onPressed: () {
              FavoritesRoute().go(context);
            },
          ),
        ],
      ),
      body: const Stack(
        fit: StackFit.expand,
        children: [
          _ImageDisplay(),
          _PageGradient(),
        ],
      ),
      floatingActionButton: state is HomeLoaded
          ? _LikeButton(
              coffee: state.coffee,
            )
          : null,
    );
  }
}

/// {@template image_display}
/// A [StatelessWidget] which is responsible for displaying the image
/// of the coffee from the [HomeBloc].
/// {@endtemplate}
class _ImageDisplay extends StatelessWidget {
  /// {@macro image_display}
  const _ImageDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state) {
          HomeLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          HomeLoaded() => Image.memory(
              state.coffee.image,
              fit: BoxFit.cover,
            ),
          HomeError() || _ => const _DisplayHomeError(
              key: Key('home_error'),
            ),
        };
      },
    );
  }
}

class _DisplayHomeError extends StatelessWidget {
  const _DisplayHomeError({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.select((HomeBloc bloc) => bloc.state);

    if (state is HomeError && state.reason == HomeErrorReason.networkError) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off_outlined,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.networkErrorLoadingImage,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Center(
      child: Text(l10n.errorLoadingImage),
    );
  }
}

class _PageGradient extends StatelessWidget {
  const _PageGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black87,
            Colors.transparent,
            Colors.transparent,
            Colors.black87,
          ],
          stops: [
            0.0,
            0.4,
            0.7,
            1.0,
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton({
    required this.coffee,
  });

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final liked = state.isFavorite(coffee);
        final favoriteLoading = state.isLoading;

        return FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          focusElevation: 0,
          hoverElevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          elevation: 0,
          onPressed: liked || favoriteLoading
              ? null
              : () => context
                  .read<FavoritesBloc>()
                  .add(AddFavoriteCoffeeEvent(coffee: coffee)),
          label: Text(l10n.likeButton),
          icon: liked
              ? const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                )
              : const Icon(
                  Icons.favorite_border,
                ),
        );
      },
    );
  }
}
