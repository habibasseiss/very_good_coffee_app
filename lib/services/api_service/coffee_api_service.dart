// ignore_for_file: unused_element

import 'package:http/http.dart' as http;
import 'package:very_good_coffee_app/services/services.dart';

/// Coffee class that provides specific methods to interact with the coffee API,
/// given a [baseUrl].
class CoffeeApiService extends ApiService {
  factory CoffeeApiService({
    required String baseUrl,
    required http.Client httpClient,
  }) {
    _instance ??= CoffeeApiService._(
      httpClient: httpClient,
      baseUrl: baseUrl,
    );

    return _instance!;
  }

  CoffeeApiService._({
    required super.baseUrl,
    required super.httpClient,
    super.scheme,
    super.port,
  });

  static CoffeeApiService? _instance;

  /// Performs a GET request to the random coffee endpoint, i.e. '/random.json'.
  Future<Map<String, dynamic>> getRandom() async {
    return super.get('/random.json');
  }
}
