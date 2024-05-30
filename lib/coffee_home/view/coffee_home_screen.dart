import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

/// {@template coffee_home_screen}
/// A [StatelessWidget] which is responsible for providing a [CoffeeHomeBloc]
/// to the [CoffeeHomeView].
/// {@endtemplate}
class CoffeeHomeScreen extends StatelessWidget {
  /// {@macro coffee_home_screen}
  const CoffeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoffeeHomeBloc(
        coffeeRepository: context.read(),
      )..add(const LoadRandomCoffeeEvent()),
      child: const CoffeeHomeView(),
    );
  }
}

/// {@template coffee_home_view}
/// Displays the body of CoffeeHomeView
/// {@endtemplate}
class CoffeeHomeView extends StatelessWidget {
  /// {@macro coffee_home_view}
  const CoffeeHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = context.select((CoffeeHomeBloc bloc) => bloc.state);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: state is CoffeeHomeLoading
              ? null
              : () => context.read<CoffeeHomeBloc>().add(
                    const LoadRandomCoffeeEvent(),
                  ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
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
      floatingActionButton: state is CoffeeHomeLoading
          ? null
          : FloatingActionButton.extended(
              backgroundColor: Colors.transparent,
              focusElevation: 0,
              hoverElevation: 0,
              disabledElevation: 0,
              highlightElevation: 0,
              elevation: 0,
              onPressed: () {},
              label: Text(l10n.likeButton),
              icon: const Icon(
                Icons.favorite_border,
              ),
            ),
    );
  }
}

/// {@template image_display}
/// A [StatelessWidget] which is responsible for displaying the image
/// of the coffee from the [CoffeeHomeBloc].
/// {@endtemplate}
class _ImageDisplay extends StatelessWidget {
  /// {@macro image_display}
  const _ImageDisplay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeHomeBloc, CoffeeHomeState>(
      builder: (context, state) {
        return switch (state) {
          CoffeeHomeLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          CoffeeHomeLoaded() => Image.memory(
              state.coffee.image!,
              fit: BoxFit.cover,
            ),
          CoffeeHomeError() || _ => const Center(
              child: Text('Error loading image'),
            ),
        };
      },
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
            Colors.black54,
            Colors.transparent,
            Colors.transparent,
            Colors.black87,
          ],
          stops: [
            0.0,
            0.3,
            0.7,
            1.0,
          ],
        ),
      ),
    );
  }
}
