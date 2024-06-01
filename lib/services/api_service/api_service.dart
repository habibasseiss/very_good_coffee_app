// ignore_for_file: unused_element

import 'dart:convert';

import 'package:http/http.dart' as http;

/// Base class that provides methods to interact with an API.
abstract class ApiService {
  ApiService({
    required this.baseUrl,
    required this.httpClient,
    this.scheme = 'https',
    this.port = 443,
  });

  /// The HTTP client used to make requests, e.g. [http.Client()].
  final http.Client httpClient;

  /// The base URL for the API.
  final String baseUrl;

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

  /// Makes a [Uri] from a [path] by combining it with the [baseUrl].
  Uri makeUri(String path) {
    return Uri(
      scheme: scheme,
      host: baseUrl,
      port: port,
      path: path,
    );
  }
}
