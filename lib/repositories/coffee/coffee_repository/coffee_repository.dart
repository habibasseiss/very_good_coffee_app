import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

abstract class CoffeeRepository {
  const CoffeeRepository();

  /// Fetch a random coffee from the API, returns a [Coffee] object. Throws an
  /// [GetRandomCoffeeFailure] if an error occurs.
  Future<Coffee> getRandomCoffee();
}

/// {@template get_random_coffee_failure}
/// Failure object thrown when an error occurs while fetching a random coffee.
/// {@endtemplate}
class GetRandomCoffeeFailure implements Exception {
  /// {@macro get_random_coffee_failure}
  const GetRandomCoffeeFailure(this.message);

  final String message;
}
