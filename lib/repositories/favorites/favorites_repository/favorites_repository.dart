import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

abstract class FavoritesRepository {
  /// Get all favorited coffees.
  Future<List<Coffee>> getFavorites();

  /// Add a coffee to favorites.
  Future<int> addFavorite({required Coffee coffee});

  /// Remove a coffee from favorites.
  Future<void> removeFavorite({required Coffee coffee});
}
