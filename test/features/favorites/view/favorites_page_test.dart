// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockFavoritesRepository = MockFavoritesRepository();
  final favoritesBloc = MockFavoritesBloc();

  group('FavoritesScreen', () {
    setUp(() {
      when(mockFavoritesRepository.getFavorites).thenAnswer(
        (_) async => [],
      );
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(),
      );
    });
    testWidgets('renders FavoritesView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<FavoritesRepository>(
          create: (context) => mockFavoritesRepository,
          child: BlocProvider<FavoritesBloc>(
            create: (context) => favoritesBloc,
            child: const MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: FavoritesScreen(),
            ),
          ),
        ),
      );
      expect(find.byType(FavoritesScreen), findsOneWidget);
    });
    // TODO(habib): Add more widget tests
  });
}
