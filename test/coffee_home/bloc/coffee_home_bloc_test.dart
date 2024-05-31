// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  const testFilePath = 'https://apitest.dev/GhoCm_jVlXg_coffee.png';

  final mockApiService = MockApiService();
  final mockCoffeeRepository = MockCoffeeRepository();

  setUp(() {
    when(() => mockApiService.get('/random.json')).thenAnswer(
      (_) async => <String, dynamic>{
        'file': testFilePath,
      },
    );

    when(mockCoffeeRepository.getRandomCoffee).thenAnswer(
      (_) async => Coffee(
        image: testMemoryImage,
        url: testFilePath,
      ),
    );
  });

  group('CoffeeHomeBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CoffeeHomeBloc(
            coffeeRepository: mockCoffeeRepository,
          ),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final coffeeHomeBloc = CoffeeHomeBloc(
        coffeeRepository: mockCoffeeRepository,
      );
      expect(coffeeHomeBloc.state, equals(CoffeeHomeInitial()));
    });

    blocTest<CoffeeHomeBloc, CoffeeHomeState>(
      'emits [CoffeeHomeLoading, CoffeeHomeLoaded] when LoadRandomPhotoEvent is successful',
      build: () => CoffeeHomeBloc(
        coffeeRepository: mockCoffeeRepository,
      ),
      act: (bloc) => bloc.add(const LoadRandomCoffeeEvent()),
      expect: () => <CoffeeHomeState>[
        const CoffeeHomeLoading(),
        CoffeeHomeLoaded(
          coffee: Coffee(
            image: testMemoryImage,
            url: testFilePath,
          ),
        ),
      ],
    );

    blocTest<CoffeeHomeBloc, CoffeeHomeState>(
      'emits [CoffeeHomeLoading, CoffeeHomeError] when LoadRandomPhotoEvent is unsuccessful',
      setUp: () {
        when(mockCoffeeRepository.getRandomCoffee).thenThrow(
          GetRandomCoffeeFailure('Failed to fetch a random coffee'),
        );
      },
      build: () => CoffeeHomeBloc(
        coffeeRepository: mockCoffeeRepository,
      ),
      act: (bloc) => bloc.add(const LoadRandomCoffeeEvent()),
      expect: () => <CoffeeHomeState>[
        const CoffeeHomeLoading(),
        const CoffeeHomeError('Failed to fetch a random coffee'),
      ],
    );
  });
}
