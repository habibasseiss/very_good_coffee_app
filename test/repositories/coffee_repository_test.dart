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
          (c) => c.url,
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

  group('Coffee and CoffeeResponse Model', () {
    test('Test Coffee Model', () async {
      final coffee = Coffee(
        image: testMemoryImage,
        url: testFilePath,
      );

      // Test copyWith with null url, should retain original url
      expect(
        coffee.copyWith().url,
        equals(coffee.url),
      );

      // Test copyWith with a new url and null image
      expect(
        coffee.copyWith(
          url: 'new/file/path',
        ),
        equals(
          Coffee(
            image: testMemoryImage,
            url: 'new/file/path',
          ),
        ),
      );
    });

    test('Test CoffeeResponse Model', () async {
      const coffeeResponse = CoffeeResponse(
        file: testFilePath,
      );

      final coffeeResponseJson = coffeeResponse.toJson();

      expect(coffeeResponse.file, coffeeResponseJson['file']);

      // Test copyWith with null file, should retain original file
      expect(
        coffeeResponse.copyWith().file,
        equals(coffeeResponse.file),
      );

      // Test copyWith with a new file and null image
      expect(
        coffeeResponse.copyWith(
          file: 'new/file/path',
        ),
        equals(
          const CoffeeResponse(
            file: 'new/file/path',
          ),
        ),
      );
    });
  });
}
