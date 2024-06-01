import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/api_service/coffee_api_service.dart';

import '../helpers/helpers.dart';

class MockCoffeeApiService extends Mock implements CoffeeApiService {}

void main() {
  final testFilePath = testCoffee1.url;

  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockCoffeeApiService();
  final apiCoffeeRepository = ApiCoffeeRepository(
    coffeeApiService: mockApiService,
  );

  group('Testing Coffee Repository', () {
    setUp(() {
      when(mockApiService.getRandom).thenAnswer(
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

  group('Testing Coffee Repository SocketException Exception', () {
    setUp(() {
      when(mockApiService.getRandom).thenThrow(
        const SocketException('Failed to fetch a random coffee'),
      );
    });
    test('Test get random coffee should throw exception', () async {
      expect(
        () async => apiCoffeeRepository.getRandomCoffee(),
        throwsA(
          isA<GetRandomCoffeeFailure>().having(
            (e) => e.reason,
            'reason',
            GetRandomCoffeeFailureReason.networkError,
          ),
        ),
      );
    });
  });

  group('Testing Coffee Repository SocketException Exception', () {
    setUp(() {
      when(mockApiService.getRandom).thenThrow(
        const HttpException('Failed to fetch a random coffee'),
      );
    });
    test('Test get random coffee should throw exception', () async {
      expect(
        () async => apiCoffeeRepository.getRandomCoffee(),
        throwsA(
          isA<GetRandomCoffeeFailure>().having(
            (e) => e.reason,
            'reason',
            GetRandomCoffeeFailureReason.networkError,
          ),
        ),
      );
    });
  });

  group('Testing Coffee Repository SocketException Exception', () {
    setUp(() {
      when(mockApiService.getRandom).thenThrow(
        TimeoutException('Failed to fetch a random coffee'),
      );
    });
    test('Test get random coffee should throw exception', () async {
      expect(
        () async => apiCoffeeRepository.getRandomCoffee(),
        throwsA(
          isA<GetRandomCoffeeFailure>().having(
            (e) => e.reason,
            'reason',
            GetRandomCoffeeFailureReason.networkError,
          ),
        ),
      );
    });
  });

  group('Testing Coffee Repository Generic Exception', () {
    setUp(() {
      when(mockApiService.getRandom).thenThrow(
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
    test('Test CoffeeResponse Model', () async {
      final coffeeResponse = CoffeeResponse(
        file: testFilePath,
      );
      final coffeeResponseJson = coffeeResponse.toJson();
      expect(coffeeResponse.file, equals(coffeeResponseJson['file']));

      // two instances with the same properties are equal
      const coffeeResponse1 = CoffeeResponse(file: 'path/to/file');
      const coffeeResponse2 = CoffeeResponse(file: 'path/to/file');
      expect(coffeeResponse1, coffeeResponse2);

      // two instances with different properties are not equal
      const coffeeResponse3 = CoffeeResponse(file: 'path/to/file');
      const coffeeResponse4 = CoffeeResponse(file: 'path/to/other/file');
      expect(coffeeResponse3, isNot(equals(coffeeResponse4)));
    });
  });
}
