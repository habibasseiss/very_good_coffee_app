// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/favorites/bloc/favorites_bloc.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('FavoritesEvent', () {
    group('LoadFavoritesEvent', () {
      test('supports value equality', () {
        expect(
          LoadFavoritesEvent(),
          equals(const LoadFavoritesEvent()),
        );
        expect(
          AddFavoriteCoffeeEvent(coffee: testCoffee1),
          equals(AddFavoriteCoffeeEvent(coffee: testCoffee1)),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const LoadFavoritesEvent(),
          isNotNull,
        );
      });
    });
  });
}
