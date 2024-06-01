import 'package:very_good_coffee_app/repositories/coffee/models/models.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';
import 'package:very_good_coffee_app/services/database_service/database_service.dart';

/// {@template api_favorites_repository}
/// [FavoritesRepository]
/// {@endtemplate}
class ApiFavoritesRepository extends FavoritesRepository {
  /// {@macro api_favorites_repository}
  ApiFavoritesRepository({
    required this.databaseService,
  });

  final DatabaseService databaseService;

  @override
  Future<int> addFavorite({required Coffee coffee}) {
    return databaseService.coffeeDao.insertCoffee(coffee);
  }

  @override
  Future<List<Coffee>> getFavorites() {
    return databaseService.coffeeDao.selectAllCoffees();
  }

  @override
  Future<void> removeFavorite({required Coffee coffee}) {
    return databaseService.coffeeDao.deleteCoffee(coffee);
  }
}
