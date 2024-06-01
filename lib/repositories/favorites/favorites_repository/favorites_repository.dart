import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

abstract class FavoritesRepository {
  /// Get all favorited coffees.
  Future<List<Coffee>> getFavorites();

  /// Get a favorited coffee by [url].
  Future<Coffee?> getFavorite({required String url});

  /// Add a coffee to favorites. Returns the id of the added coffee. If the
  /// coffee is already favorited, returns the id of the existing coffee.
  Future<int?> addFavorite({required Coffee coffee});

  /// Remove a coffee from favorites.
  Future<void> removeFavorite({required Coffee coffee});
}
