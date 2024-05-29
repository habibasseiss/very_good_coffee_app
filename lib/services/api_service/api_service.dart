import 'package:http/http.dart' as http;

/// Singleton class that provides methods to interact with an API, given a
/// [baseUrl].
class ApiService {
  factory ApiService({required String baseUrl}) {
    _instance ??= ApiService._(
      baseUrl: baseUrl,
    );

    return _instance!;
  }

  ApiService._({
    required this.baseUrl,
  });

  static ApiService? _instance;

  /// The base URL for the API.
  final String baseUrl;

  /// Performs a GET request at [path] to the API.
  Future<http.Response> get(String path) {
    final uri = _makeUri(path);

    return http.get(uri);
  }

  /// Makes a [Uri] from a [path] by combining [baseUrl] and [path].
  Uri _makeUri(String path) {
    return Uri(
      scheme: 'https',
      host: baseUrl,
      path: path,
    );
  }
}
