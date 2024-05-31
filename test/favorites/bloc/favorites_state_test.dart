// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/repositories/coffee/models/models.dart';

import '../../helpers/helpers.dart';

void main() {
  final testCoffee = Coffee(
    image: testMemoryImage,
    url: 'https://apitest.dev/GhoCm_jVlXg_coffee.png',
  );

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

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          final favoritesState = FavoritesState(
            coffees: [
              testCoffee,
            ],
          );

          expect(
            favoritesState.copyWith(),
            equals(favoritesState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          final favoritesState = FavoritesState(
            coffees: [
              testCoffee,
            ],
          );
          final otherFavoritesState = FavoritesState(
            coffees: [
              testCoffee,
            ],
            isLoading: true,
          );
          expect(favoritesState, isNot(equals(otherFavoritesState)));

          expect(
            favoritesState.copyWith(
              isLoading: true,
            ),
            equals(otherFavoritesState),
          );
        },
      );
    });
  });
}
