import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

/// {@template api_coffee_repository}
/// [CoffeeRepository]
/// {@endtemplate}
class ApiCoffeeRepository extends CoffeeRepository {
  /// {@macro api_coffee_repository}
  ApiCoffeeRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  /// The service used to interact with the API.
  final ApiService _apiService;

  @override
  Future<Coffee> getRandomCoffee() async {
    try {
      final response = await _apiService.get('/random.json');

      return Coffee.fromJson(response);
    } on Exception catch (e) {
      throw GetRandomCoffeeFailure('Failed to fetch a random coffee: $e');
    }
  }
}
