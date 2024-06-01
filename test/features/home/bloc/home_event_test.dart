// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/home/home.dart';

void main() {
  group('HomeEvent', () {
    group('LoadRandomPhotoEvent', () {
      test('supports value equality', () {
        expect(
          LoadRandomCoffeeEvent(),
          equals(const LoadRandomCoffeeEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const LoadRandomCoffeeEvent(),
          isNotNull,
        );
      });
    });
  });
}
