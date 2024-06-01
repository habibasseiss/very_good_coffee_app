// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/features/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';

import '../../../helpers/helpers.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  final mockFavoritesRepository = MockFavoritesRepository();

  group('FavoritesBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          FavoritesBloc(
            favoritesRepository: mockFavoritesRepository,
          ),
          isNotNull,
        );
      });
    });

    test('initial state has default values', () {
      final favoritesBloc = FavoritesBloc(
        favoritesRepository: mockFavoritesRepository,
      );
      expect(favoritesBloc.state.coffees, equals([]));
      expect(favoritesBloc.state.isLoading, equals(false));
    });

    blocTest<FavoritesBloc, FavoritesState>(
      'emits correct state values when LoadFavoritesEvent is added',
      setUp: () {
        when(mockFavoritesRepository.getFavorites).thenAnswer(
          (_) async => [testCoffee1],
        );
      },
      build: () => FavoritesBloc(
        favoritesRepository: mockFavoritesRepository,
      ),
      act: (bloc) => bloc.add(const LoadFavoritesEvent()),
      expect: () => <FavoritesState>[
        const FavoritesState(isLoading: true),
        FavoritesState(coffees: [testCoffee1]),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits correct state values when AddFavoriteCoffeeEvent is added',
      setUp: () {
        when(() => mockFavoritesRepository.addFavorite(coffee: testCoffee1))
            .thenAnswer(
          (_) async => testCoffee1.id,
        );
      },
      build: () => FavoritesBloc(
        favoritesRepository: mockFavoritesRepository,
      ),
      act: (bloc) => bloc.add(AddFavoriteCoffeeEvent(coffee: testCoffee1)),
      expect: () => <FavoritesState>[
        const FavoritesState(isLoading: true),
        FavoritesState(coffees: [testCoffee1]),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits correct state values when AddFavoriteCoffeeEvent is added for an existing coffee',
      setUp: () {
        when(() => mockFavoritesRepository.addFavorite(coffee: testCoffee2))
            .thenAnswer(
          (_) async => testCoffee2.id,
        );
      },
      build: () => FavoritesBloc(
        favoritesRepository: mockFavoritesRepository,
      ),
      seed: () => FavoritesState(coffees: [testCoffee1, testCoffee2]),
      act: (bloc) => bloc.add(AddFavoriteCoffeeEvent(coffee: testCoffee2)),
      expect: () => <FavoritesState>[
        FavoritesState(coffees: [testCoffee1, testCoffee2], isLoading: true),
        FavoritesState(coffees: [testCoffee1, testCoffee2]),
      ],
    );
  });
}
