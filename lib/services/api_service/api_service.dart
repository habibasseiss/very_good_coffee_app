// ignore_for_file: unused_element

import 'dart:convert';

import 'package:http/http.dart' as http;

/// Singleton class that provides methods to interact with an API, given a
/// [endpoint].
class ApiService {
  factory ApiService({required String endpoint}) {
    _instance ??= ApiService._(
      endpoint: endpoint,
    );

    return _instance!;
  }

  ApiService._({
    required this.endpoint,
    this.scheme = 'https',
    this.port = 443,
  });

  static ApiService? _instance;

  /// The base URL (endpoint for the API).
  final String endpoint;

  /// The URI scheme.
  final String scheme;

  /// The port to connect to.
  final int port;

  /// Performs a GET request at [path] to the API.
  Future<Map<String, dynamic>> get(String path) async {
    final uri = _makeUri(path);
    final response = await http.get(uri);

    return json.decode(response.body) as Map<String, dynamic>;
  }

  /// Makes a [Uri] from a [path] by combining [endpoint] and [path].
  Uri _makeUri(String path) {
    return Uri(
      scheme: scheme,
      host: endpoint,
      port: port,
      path: path,
    );
  }
}
