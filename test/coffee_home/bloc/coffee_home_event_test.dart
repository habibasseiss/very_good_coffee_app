// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';

void main() {
  group('CoffeeHomeEvent', () {
    group('LoadRandomPhotoEvent', () {
      test('supports value equality', () {
        expect(
          LoadRandomPhotoEvent(),
          equals(const LoadRandomPhotoEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const LoadRandomPhotoEvent(),
          isNotNull,
        );
      });
    });
  });
}
