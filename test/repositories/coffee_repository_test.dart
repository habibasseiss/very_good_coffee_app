import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  const testFilePath = 'https://apitest.dev/GhoCm_jVlXg_coffee.png';

  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockApiService();
  final apiCoffeeRepository = ApiCoffeeRepository(
    apiService: mockApiService,
  );

  group('Testing Coffee Repository', () {
    setUp(() {
      when(() => mockApiService.get('/random.json')).thenAnswer(
        (_) async => <String, dynamic>{
          'file': testFilePath,
        },
      );
    });
    test('Test get random coffee', () async {
      expect(
        await apiCoffeeRepository.getRandomCoffee(),
        isA<Coffee>().having(
          (c) => c.file,
          'file url',
          testFilePath,
        ),
      );
    });
  });

  group('Testing Coffee Repository Exception', () {
    setUp(() {
      when(() => mockApiService.get('/random.json')).thenThrow(
        Exception('Failed to fetch a random coffee'),
      );
    });
    test('Test get random coffee should throw exception', () async {
      expect(
        () async => apiCoffeeRepository.getRandomCoffee(),
        throwsA(isA<GetRandomCoffeeFailure>()),
      );
    });
  });

  group('Coffee Model', () {
    test('Test Coffee Model', () async {
      final coffee = Coffee(
        file: testFilePath,
        image: testMemoryImage,
      );

      final coffeeJson = coffee.toJson();

      expect(coffee.file, coffeeJson['file']);

      expect(
        coffee.copyWith(
          image: Uint8List(0),
        ),
        isNot(coffee),
      );

      expect(
        coffee.copyWith(
          image: testMemoryImage,
        ),
        equals(coffee),
      );

      // Test copyWith with null image, should retain original image
      expect(
        coffee.copyWith().image,
        equals(coffee.image),
      );

      // Test copyWith with a new file and null image
      expect(
        coffee.copyWith(
          file: 'new/file/path',
        ),
        equals(
          Coffee(
            file: 'new/file/path',
            image: testMemoryImage,
          ),
        ),
      );
    });
  });
}
