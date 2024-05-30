import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/routes.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockCoffeeHomeBloc extends MockBloc<CoffeeHomeEvent, CoffeeHomeState>
    implements CoffeeHomeBloc {}

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
          file: testFilePath,
          image: Uint8List(0),
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
      final bloc = MockCoffeeHomeBloc();
      final goRouter = MockGoRouter();

      when(() => bloc.state).thenReturn(
        CoffeeHomeLoaded(
          coffee: Coffee(
            file: testFilePath,
            image: testMemoryImage,
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
              child: BlocProvider<CoffeeHomeBloc>(
                create: (context) => bloc,
                child: const CoffeeHomeView(),
              ),
            ),
          ),
        ),
      );

      // Refresh button should load a random photo
      await tester.tap(find.byIcon(Icons.refresh));
      verify(() => bloc.add(const LoadRandomCoffeeEvent())).called(1);

      // List button should navigate to favorites screen
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      verify(() => goRouter.go(FavoritesRoute().location)).called(1);

      // Like button should do nothing (for now)
      await tester.tap(find.byIcon(Icons.favorite_border));
      verifyNever(() => bloc.add(const LikeCoffeeEvent()));
    });
  });
}
