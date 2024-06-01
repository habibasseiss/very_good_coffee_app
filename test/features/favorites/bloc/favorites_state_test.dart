// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';

void main() {
  group('FavoritesState', () {
    test('supports value equality', () {
      expect(
        FavoritesState(),
        equals(
          const FavoritesState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const FavoritesState(),
          isNotNull,
        );
      });
    });
  });
}
