import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/favorites/favorites.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockCoffeeHomeBloc extends MockBloc<CoffeeHomeEvent, CoffeeHomeState>
    implements CoffeeHomeBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  const testFilePath = 'https://apitest.dev/GhoCm_jVlXg_coffee.png';

  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockApiService();
  final mockCoffeeRepository = MockCoffeeRepository();

  group('CoffeeHomeScreen', () {
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

    testWidgets('renders CoffeeHomePage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<CoffeeRepository>(
          create: (context) => mockCoffeeRepository,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: CoffeeHomeScreen(),
          ),
        ),
      );
      expect(find.byType(CoffeeHomeView), findsOneWidget);
    });

    testWidgets('renders CoffeeHomeView', (tester) async {
      final homeBbloc = MockCoffeeHomeBloc();
      final favoritesBloc = MockFavoritesBloc();

      final goRouter = MockGoRouter();

      when(() => homeBbloc.state).thenReturn(
        CoffeeHomeLoaded(
          coffee: Coffee(
            image: testMemoryImage,
            url: testFilePath,
          ),
        ),
      );

      await tester.pumpWidget(
        RepositoryProvider<CoffeeRepository>(
          create: (context) => MockCoffeeRepository(),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: MockGoRouterProvider(
              goRouter: goRouter,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<CoffeeHomeBloc>(
                    create: (context) => homeBbloc,
                  ),
                  BlocProvider<FavoritesBloc>(
                    create: (context) => favoritesBloc,
                  ),
                ],
                child: const CoffeeHomeView(),
              ),
            ),
          ),
        ),
      );

      // Refresh button should load a random photo
      await tester.tap(find.byIcon(Icons.refresh));
      verify(() => homeBbloc.add(const LoadRandomCoffeeEvent())).called(1);

      // List button should navigate to favorites screen
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      verify(() => goRouter.go(FavoritesRoute().location)).called(1);

      // Like button should do nothing (for now)
      await tester.tap(find.byIcon(Icons.favorite_border));
      verifyNever(() => homeBbloc.add(const LikeCoffeeEvent()));
    });
  });
}
