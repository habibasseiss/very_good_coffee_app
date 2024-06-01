// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/features/home/home.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  final testFilePath = testCoffee1.url;

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

  group('HomeBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          HomeBloc(
            coffeeRepository: mockCoffeeRepository,
          ),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final homeBloc = HomeBloc(
        coffeeRepository: mockCoffeeRepository,
      );
      expect(homeBloc.state, equals(HomeInitial()));
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeLoaded] when LoadRandomPhotoEvent is successful',
      build: () => HomeBloc(
        coffeeRepository: mockCoffeeRepository,
      ),
      act: (bloc) => bloc.add(const LoadRandomCoffeeEvent()),
      expect: () => <HomeState>[
        const HomeLoading(),
        HomeLoaded(
          coffee: Coffee(
            image: testMemoryImage,
            url: testFilePath,
          ),
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when LoadRandomPhotoEvent is unsuccessful',
      setUp: () {
        when(mockCoffeeRepository.getRandomCoffee).thenThrow(
          GetRandomCoffeeFailure('Failed to fetch a random coffee'),
        );
      },
      build: () => HomeBloc(
        coffeeRepository: mockCoffeeRepository,
      ),
      act: (bloc) => bloc.add(const LoadRandomCoffeeEvent()),
      expect: () => <HomeState>[
        const HomeLoading(),
        const HomeError('Failed to fetch a random coffee'),
      ],
    );
  });
}
