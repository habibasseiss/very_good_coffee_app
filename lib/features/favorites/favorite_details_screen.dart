import 'package:flutter/material.dart';

class FavoriteDetailsScreen extends StatelessWidget {
  const FavoriteDetailsScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite $id'),
      ),
    );
  }
}
