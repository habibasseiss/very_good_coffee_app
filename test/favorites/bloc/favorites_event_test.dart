// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/repositories/coffee/models/models.dart';

import '../../helpers/helpers.dart';

void main() {
  final coffee = Coffee(
    image: testMemoryImage,
  );

  group('FavoritesEvent', () {
    group('LoadFavoritesEvent', () {
      test('supports value equality', () {
        expect(
          LoadFavoritesEvent(),
          equals(const LoadFavoritesEvent()),
        );
        expect(
          AddFavoriteCoffeeEvent(coffee: coffee),
          equals(AddFavoriteCoffeeEvent(coffee: coffee)),
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
