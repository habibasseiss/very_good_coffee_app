import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/routes.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < 5; i++)
            ListTile(
              title: Text('Favorite $i'),
              onTap: () => FavoriteDetailsRoute(id: i.toString()).go(context),
            ),
        ],
      ),
    );
  }
}
