import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              FavoritesRoute().go(context);
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            // 'https://coffee.alexflipnote.dev/6quoeA0jMy8_coffee.png',
            // 'https://coffee.alexflipnote.dev/GhoCm_jVlXg_coffee.png',
            'https://coffee.alexflipnote.dev/VUUgS-L41c8_coffee.jpg',
            fit: BoxFit.cover,
          ),
          const _PageGradient(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
