// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';

import '../../../helpers/helpers.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockFavoritesRepository = MockFavoritesRepository();
  final favoritesBloc = MockFavoritesBloc();

  final goRouter = MockGoRouter();

  final favoritesScreen = RepositoryProvider<FavoritesRepository>(
    create: (context) => mockFavoritesRepository,
    child: BlocProvider<FavoritesBloc>(
      create: (context) => favoritesBloc,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: MockGoRouterProvider(
          goRouter: goRouter,
          child: FavoritesScreen(),
        ),
      ),
    ),
  );

  group('FavoritesScreen when favorites are empty', () {
    setUp(() {
      when(mockFavoritesRepository.getFavorites).thenAnswer(
        (_) async => [],
      );
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(),
      );
    });
    testWidgets('renders FavoritesScreen', (tester) async {
      await tester.pumpWidget(favoritesScreen);
      expect(find.byType(FavoritesScreen), findsOneWidget);
      expect(
        find.byKey(const Key('favorites_screen_no_navorites_text')),
        findsOneWidget,
      );
    });
  });

  group('FavoritesScreen when favorites are not empty', () {
    setUp(() {
      when(mockFavoritesRepository.getFavorites).thenAnswer(
        (_) async => [],
      );
      when(() => favoritesBloc.state).thenReturn(
        FavoritesState(coffees: [testCoffee1, testCoffee2]),
      );
    });

    testWidgets('renders FavoritesScreen', (tester) async {
      await tester.pumpWidget(favoritesScreen);
      expect(find.byType(FavoritesScreen), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);

      // grid view image item should navigate to favorites details screen
      await tester.tap(find.byType(Image).first);
      await tester.pumpAndSettle();
      verify(() => goRouter.go(FavoriteDetailsRoute(id: '1').location))
          .called(1);
    });
  });
}
