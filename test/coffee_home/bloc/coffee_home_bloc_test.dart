// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  final mockApiService = MockApiService();
  final apiCoffeeRepository = ApiCoffeeRepository(
    apiService: mockApiService,
  );

  const testFilePath = '$apiUrl/GhoCm_jVlXg_coffee.png';

  setUp(() {
    when(() => mockApiService.get('/random.json')).thenAnswer(
      (_) async => <String, dynamic>{
        'file': testFilePath,
      },
    );
  });

  group('CoffeeHomeBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CoffeeHomeBloc(
            coffeeRepository: apiCoffeeRepository,
          ),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final coffeeHomeBloc = CoffeeHomeBloc(
        coffeeRepository: apiCoffeeRepository,
      );
      expect(coffeeHomeBloc.state, equals(CoffeeHomeInitial()));
    });

    blocTest<CoffeeHomeBloc, CoffeeHomeState>(
      'LoadRandomPhotoEvent loads a random photo',
      build: () => CoffeeHomeBloc(
        coffeeRepository: apiCoffeeRepository,
      ),
      act: (bloc) => bloc.add(const LoadRandomPhotoEvent()),
      expect: () => <CoffeeHomeState>[
        const CoffeeHomeLoading(),
        CoffeeHomeLoaded(
          coffee: Coffee(
            file: testFilePath,
          ),
        ),
      ],
    );
  });
}
