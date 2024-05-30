import 'package:http/http.dart' as http;
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
      // Fetch a random coffee from the API.
      final response = await _apiService.get('/random.json');

      // Create a [Coffee] object from the API response.
      final coffee = Coffee.fromJson(response);

      // Manually fetch the image from the obtained url and store it in memory.
      final imageUrl = response['file'] as String;
      final imageResponse = await http.get(Uri.parse(imageUrl));
      final image = imageResponse.bodyBytes;

      return coffee.copyWith(
        image: image,
      );
    } on Exception catch (e) {
      throw GetRandomCoffeeFailure('Failed to fetch a random coffee: $e');
    }
  }
}
