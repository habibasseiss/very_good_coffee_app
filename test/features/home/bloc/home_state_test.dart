// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/home/home.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('HomeState', () {
    test('supports value equality', () {
      expect(
        const HomeInitial(),
        equals(
          const HomeInitial(),
        ),
      );
      expect(
        const HomeLoading(),
        equals(
          const HomeLoading(),
        ),
      );
      expect(
        HomeLoaded(
          coffee: testCoffee1,
        ),
        equals(
          HomeLoaded(
            coffee: testCoffee1,
          ),
        ),
      );
      expect(
        const HomeError('error'),
        equals(
          const HomeError('error'),
        ),
      );
    });
  });
}
