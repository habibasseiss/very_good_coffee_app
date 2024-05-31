// ignore_for_file: prefer_const_constructors, lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/favorites/bloc/favorites_bloc.dart';
import 'package:very_good_coffee_app/repositories/coffee/models/models.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';

import '../../helpers/helpers.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {
  final mockFavoritesRepository = MockFavoritesRepository();

  final testCoffee = Coffee(
    image: testMemoryImage,
    url: 'https://apitest.dev/GhoCm_jVlXg_coffee.png',
  );

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
          (_) async => [testCoffee],
        );
      },
      build: () => FavoritesBloc(
        favoritesRepository: mockFavoritesRepository,
      ),
      act: (bloc) => bloc.add(const LoadFavoritesEvent()),
      expect: () => <FavoritesState>[
        const FavoritesState(isLoading: true),
        FavoritesState(coffees: [testCoffee]),
      ],
    );
  });
}
