import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/dao/coffee_dao.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';
import 'package:very_good_coffee_app/services/database_service/database_service.dart';

import '../helpers/helpers.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

class MockCoffeeDao extends Mock implements CoffeeDao {}

void main() {
  final coffee1 = Coffee(
    image: testMemoryImage,
    url: 'https://apitest.dev/GhoCm_jVlXg_coffee.png',
  );
  final coffee2 = Coffee(
    image: testMemoryImage,
    url: 'https://apitest.dev/sx9j_28sl1m.png',
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  late DatabaseService database;
  late FavoritesRepository favoritesRepository;
  late CoffeeDao coffeeDao;

  setUp(() async {
    database = MockDatabaseService();
    coffeeDao = MockCoffeeDao();
    favoritesRepository = ApiFavoritesRepository(
      databaseService: database,
    );
  });

  group('Testing Favorites Repository', () {
    setUp(() {
      when(() => database.coffeeDao).thenAnswer(
        (_) => coffeeDao,
      );
      when(coffeeDao.selectAllCoffees).thenAnswer(
        (_) async => [coffee1, coffee2],
      );
    });

    test('Test get all cofees', () async {
      expect(
        await favoritesRepository.getFavorites(),
        isA<List<Coffee>>().having(
          (coffees) => coffees.length,
          'length',
          2,
        ),
      );
    });

    // TODO(habib): Add other repository tests
  });
}
