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

  group('Testing add from favorites repository', () {
    setUp(() {
      when(() => database.coffeeDao).thenAnswer(
        (_) => coffeeDao,
      );
      when(() => coffeeDao.selectCoffeeByUrl(testCoffee1.url)).thenAnswer(
        (_) async => testCoffee1,
      );
      when(() => coffeeDao.selectCoffeeByUrl(testCoffee2.url)).thenAnswer(
        (_) async => null,
      );
      when(() => coffeeDao.insertCoffee(testCoffee1)).thenAnswer(
        (_) async => testCoffee1.id!,
      );
      when(() => coffeeDao.insertCoffee(testCoffee2)).thenAnswer(
        (_) async => testCoffee2.id!,
      );
    });

    test('Test add favorite cofee', () async {
      expect(
        await favoritesRepository.addFavorite(coffee: testCoffee1),
        isA<int>().having(
          (coffeeId) => coffeeId,
          'match coffee id',
          testCoffee1.id,
        ),
      );
      expect(
        await favoritesRepository.addFavorite(coffee: testCoffee2),
        isA<int>().having(
          (coffeeId) => coffeeId,
          'match coffee id',
          testCoffee2.id,
        ),
      );
    });
  });

  group('Testing read from favorites repository', () {
    setUp(() {
      when(() => database.coffeeDao).thenAnswer(
        (_) => coffeeDao,
      );
      when(coffeeDao.selectAllCoffees).thenAnswer(
        (_) async => [testCoffee1, testCoffee2],
      );
      when(() => coffeeDao.selectCoffeeByUrl(testCoffee1.url)).thenAnswer(
        (_) async => testCoffee1,
      );
      when(
        () => coffeeDao.selectCoffeeByUrl('http://non-existing-favorite.dev'),
      ).thenAnswer(
        (_) async => null,
      );
    });

    test('Test get all favorite cofees', () async {
      expect(
        await favoritesRepository.getFavorites(),
        isA<List<Coffee>>().having(
          (coffees) => coffees.length,
          'length',
          2,
        ),
      );
    });

    test('Test get specific favorite cofee', () async {
      expect(
        await favoritesRepository.getFavorite(url: testCoffee1.url),
        isA<Coffee>().having(
          (coffees) => coffees.url,
          'url',
          testCoffee1.url,
        ),
      );
    });

    test('Test get non existing favorite cofee', () async {
      expect(
        await favoritesRepository.getFavorite(
          url: 'http://non-existing-favorite.dev',
        ),
        isNull,
      );
    });
  });
}
