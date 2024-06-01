// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

import '../../../helpers/helpers.dart';

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final favoritesBloc = MockFavoritesBloc();

  final favoriteDetailsScreen = BlocProvider<FavoritesBloc>(
    create: (context) => favoritesBloc,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: FavoriteDetailsScreen(id: testCoffee1.id.toString()),
    ),
  );

  group('renders FavoriteDetailsScreen', () {
    setUp(() {
      when(() => favoritesBloc.state).thenReturn(
        FavoritesState(coffees: [testCoffee1, testCoffee2]),
      );
    });

    testWidgets('renders FavoriteDetailsScreen', (tester) async {
      await tester.pumpWidget(favoriteDetailsScreen);

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
