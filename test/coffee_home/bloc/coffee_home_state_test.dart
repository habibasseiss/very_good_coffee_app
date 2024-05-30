// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

import '../../helpers/helpers.dart';

void main() {
  const testFilePath = '$apiUrl/GhoCm_jVlXg_coffee.png';

  final coffee = Coffee(
    file: testFilePath,
  );

  group('CoffeeHomeState', () {
    test('supports value equality', () {
      expect(
        const CoffeeHomeInitial(),
        equals(
          const CoffeeHomeInitial(),
        ),
      );
      expect(
        const CoffeeHomeLoading(),
        equals(
          const CoffeeHomeLoading(),
        ),
      );
      expect(
        CoffeeHomeLoaded(
          coffee: coffee,
        ),
        equals(
          CoffeeHomeLoaded(
            coffee: coffee,
          ),
        ),
      );
      expect(
        const CoffeeHomeError('error'),
        equals(
          const CoffeeHomeError('error'),
        ),
      );
    });
  });
}
