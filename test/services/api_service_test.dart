import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/services/api_service/api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const endpoint = 'api.example.com';

  final mockHttpClient = MockHttpClient();

  final apiService = ApiService(
    endpoint: endpoint,
    httpClient: mockHttpClient,
  );

  group('ApiService', () {
    test('ApiService singleton instance is created with given endpoint', () {
      final anotherApiService = ApiService(
        endpoint: 'another.endpoint.com',
        httpClient: mockHttpClient,
      );
      expect(anotherApiService, apiService);
      expect(apiService.endpoint, endpoint);
    });

    test('ApiService creates correct URI', () {
      final uri = apiService.makeUri('/test-path');
      expect(
        uri,
        Uri(
          scheme: 'https',
          host: endpoint,
          port: 443,
          path: '/test-path',
        ),
      );
    });
  });

  group('ApiService requests', () {
    final productsUri = apiService.makeUri('/products');
    registerFallbackValue(productsUri);

    final mockResponse = {
      'data': [
        {'id': 1, 'name': 'Coffee Beans'},
        {'id': 2, 'name': 'Espresso Machine'},
      ],
    };

    setUp(() {
      when(() => mockHttpClient.get(productsUri)).thenAnswer(
        (_) async => http.Response(json.encode(mockResponse), 200),
      );
    });

    test('get method returns data from API', () async {
      final response = await apiService.get('/products');
      expect(response, mockResponse);
    });
  });
}
