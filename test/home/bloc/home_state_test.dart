// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/features/home/home.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

import '../../helpers/helpers.dart';

void main() {
  const testFilePath = 'https://apitest.dev/GhoCm_jVlXg_coffee.png';

  final coffee = Coffee(
    url: testFilePath,
    image: testMemoryImage,
  );

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
          coffee: coffee,
        ),
        equals(
          HomeLoaded(
            coffee: coffee,
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
