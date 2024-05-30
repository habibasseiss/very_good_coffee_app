// ignore_for_file: unused_element

import 'dart:convert';

import 'package:http/http.dart' as http;

/// Singleton class that provides methods to interact with an API, given a
/// [endpoint].
class ApiService {
  factory ApiService({
    required String endpoint,
    required http.Client httpClient,
  }) {
    _instance ??= ApiService._(
      httpClient: httpClient,
      endpoint: endpoint,
    );

    return _instance!;
  }

  ApiService._({
    required this.endpoint,
    required this.httpClient,
    this.scheme = 'https',
    this.port = 443,
  });

  static ApiService? _instance;

  /// The HTTP client used to make requests, e.g. [http.Client()].
  final http.Client httpClient;

  /// The base URL (endpoint for the API).
  final String endpoint;

  /// The URI scheme.
  final String scheme;

  /// The port to connect to.
  final int port;

  /// Performs a GET request at [path] to the API.
  Future<Map<String, dynamic>> get(String path) async {
    final uri = makeUri(path);
    final response = await httpClient.get(uri);

    return json.decode(response.body) as Map<String, dynamic>;
  }

  /// Makes a [Uri] from a [path] by combining it with the [endpoint].
  Uri makeUri(String path) {
    return Uri(
      scheme: scheme,
      host: endpoint,
      port: port,
      path: path,
    );
  }
}
