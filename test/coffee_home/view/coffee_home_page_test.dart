import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/coffee_home/coffee_home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

import '../../helpers/helpers.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockApiService();

  group('CoffeeHomePage', () {
    setUp(() {
      when(() => mockApiService.get('/random.json')).thenAnswer(
        (_) async => <String, dynamic>{
          'file': '$apiUrl/GhoCm_jVlXg_coffee.png',
        },
      );
    });
    testWidgets('renders CoffeeHomePage', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<CoffeeRepository>(
          create: (context) => ApiCoffeeRepository(
            apiService: mockApiService,
          ),
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: CoffeeHomeScreen(),
          ),
        ),
      );
      expect(find.byType(CoffeeHomeView), findsOneWidget);
    });
  });
}
