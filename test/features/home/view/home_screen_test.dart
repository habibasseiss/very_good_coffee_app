import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/routes/routes.dart';
import 'package:very_good_coffee_app/features/favorites/favorites.dart';
import 'package:very_good_coffee_app/features/home/home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockFavoritesBloc extends MockBloc<FavoritesEvent, FavoritesState>
    implements FavoritesBloc {}

void main() {
  final testFilePath = testCoffee1.url;

  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockApiService();
  final mockCoffeeRepository = MockCoffeeRepository();
  final mockFavoritesRepository = MockFavoritesRepository();

  final homeBloc = MockHomeBloc();
  final favoritesBloc = MockFavoritesBloc();
  final goRouter = MockGoRouter();

  final temporaryCoffee = Coffee(
    image: testMemoryImage,
    url: testFilePath,
  );

  final homeView = RepositoryProvider<CoffeeRepository>(
    create: (context) => MockCoffeeRepository(),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: MockGoRouterProvider(
        goRouter: goRouter,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => homeBloc,
            ),
            BlocProvider<FavoritesBloc>(
              create: (context) => favoritesBloc,
            ),
          ],
          child: const HomeView(),
        ),
      ),
    ),
  );

  group('HomeScreen', () {
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
      when(mockFavoritesRepository.getFavorites).thenAnswer(
        (_) async => [],
      );
      when(() => homeBloc.state).thenReturn(
        const HomeInitial(),
      );
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(),
      );
      when(() => homeBloc.state).thenReturn(
        HomeLoaded(coffee: temporaryCoffee),
      );
      when(() => favoritesBloc.state).thenReturn(
        const FavoritesState(),
      );
    });

    testWidgets('renders HomeScreen', (tester) async {
      await tester.pumpWidget(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<CoffeeRepository>(
              create: (context) => mockCoffeeRepository,
            ),
            RepositoryProvider<FavoritesRepository>(
              create: (context) => mockFavoritesRepository,
            ),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.byType(MultiBlocProvider), findsOneWidget);
      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(homeView);
      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('HomeView can reload, navigate to favorites and like coffee',
        (tester) async {
      await tester.pumpWidget(homeView);

      // Refresh button should load a random photo
      await tester.tap(find.byIcon(Icons.refresh));
      verify(() => homeBloc.add(const LoadRandomCoffeeEvent())).called(1);

      // List button should navigate to favorites screen
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      verify(() => goRouter.go(FavoritesRoute().location)).called(1);

      // Like button should add coffee to favorites
      await tester.tap(find.byIcon(Icons.favorite_border));
      verify(
        () => favoritesBloc.add(
          AddFavoriteCoffeeEvent(coffee: temporaryCoffee),
        ),
      ).called(1);
    });

    testWidgets('HomeView like button ignores already liked coffee',
        (tester) async {
      final coffee = Coffee(
        image: testMemoryImage,
        url: testFilePath,
      );

      when(() => homeBloc.state).thenReturn(
        HomeLoaded(coffee: coffee),
      );
      when(() => favoritesBloc.state).thenReturn(
        FavoritesState(
          coffees: [coffee],
        ),
      );

      await tester.pumpWidget(homeView);

      // Like button shouldn't add coffee to favorites if already liked
      await tester.tap(find.byIcon(Icons.favorite));
      verifyNever(
        () => favoritesBloc.add(
          AddFavoriteCoffeeEvent(coffee: coffee),
        ),
      );
    });

    testWidgets('HomeView displays general error message on failure',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeError('Error loading coffee'),
      );

      await tester.pumpWidget(homeView);
      expect(find.byKey(const Key('home_error')), findsOneWidget);
    });

    testWidgets('HomeView displays network error message on failure',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeError(
          'Error loading coffee',
          reason: HomeErrorReason.networkError,
        ),
      );

      await tester.pumpWidget(homeView);
      expect(find.byKey(const Key('home_error')), findsOneWidget);
    });
  });
}
