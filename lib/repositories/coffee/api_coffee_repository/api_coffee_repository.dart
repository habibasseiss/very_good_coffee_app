import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/api_service/coffee_api_service.dart';

/// {@template api_coffee_repository}
/// [CoffeeRepository]
/// {@endtemplate}
class ApiCoffeeRepository extends CoffeeRepository {
  /// {@macro api_coffee_repository}
  ApiCoffeeRepository({
    required CoffeeApiService coffeeApiService,
  }) : _coffeeApiService = coffeeApiService;

  /// The service used to interact with the API.
  final CoffeeApiService _coffeeApiService;

  @override
  Future<Coffee> getRandomCoffee() async {
    try {
      // Fetch a random coffee from the API.
      final response = await _coffeeApiService.getRandom();

      // Create a [CoffeeResponse] object from the API response.
      final coffeeResponse = CoffeeResponse.fromJson(response);

      // Manually fetch the image from the obtained url and store it in memory.
      final imageUrl = response['file'] as String;
      final imageResponse = await http.get(Uri.parse(imageUrl));
      final image = imageResponse.bodyBytes;

      return Coffee(
        image: image,
        url: coffeeResponse.file,
      );
    }
    // We catch different exceptions and throw a [GetRandomCoffeeFailure] with
    // a message and a reason. Currently, we only have one reason, but we can
    // add more granularity if needed.
    on SocketException catch (e) {
      throw GetRandomCoffeeFailure(
        'Failed to connect to the server: $e',
        reason: GetRandomCoffeeFailureReason.networkError,
      );
    } on HttpException catch (e) {
      throw GetRandomCoffeeFailure(
        'Failed to fetch a random coffee: $e',
        reason: GetRandomCoffeeFailureReason.networkError,
      );
    } on TimeoutException catch (e) {
      throw GetRandomCoffeeFailure(
        'Connection timed out: $e',
        reason: GetRandomCoffeeFailureReason.networkError,
      );
    } on Exception catch (e) {
      throw GetRandomCoffeeFailure(
        'An unknown error occurred: $e',
      );
    }
  }
}
