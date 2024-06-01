import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/services/api_service/coffee_api_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const baseUrl = 'api.example.com';

  final mockHttpClient = MockHttpClient();

  final apiService = CoffeeApiService(
    baseUrl: baseUrl,
    httpClient: mockHttpClient,
  );

  group('ApiService', () {
    test('ApiService singleton instance is created with given endpoint', () {
      final anotherApiService = CoffeeApiService(
        baseUrl: 'another.endpoint.com',
        httpClient: mockHttpClient,
      );
      expect(anotherApiService, apiService);
      expect(apiService.baseUrl, baseUrl);
    });

    test('ApiService creates correct URI', () {
      final uri = apiService.makeUri('/test-path');
      expect(
        uri,
        Uri(
          scheme: 'https',
          host: baseUrl,
          port: 443,
          path: '/test-path',
        ),
      );
    });
  });

  group('ApiService requests', () {
    final fakeUri = apiService.makeUri('/fake');
    final getRandomUri = apiService.makeUri('/random.json');
    registerFallbackValue(fakeUri);
    registerFallbackValue(getRandomUri);

    final fakeMockResponse = {
      'data': [
        {'id': 1, 'name': 'Coffee Beans'},
        {'id': 2, 'name': 'Espresso Machine'},
      ],
    };
    final randomMockResponse = {
      'file': 'https://example.com/image.jpg',
    };

    setUp(() {
      when(() => mockHttpClient.get(fakeUri)).thenAnswer(
        (_) async => http.Response(json.encode(fakeMockResponse), 200),
      );
      when(() => mockHttpClient.get(getRandomUri)).thenAnswer(
        (_) async => http.Response(json.encode(randomMockResponse), 200),
      );
    });

    test('get method returns data from API', () async {
      final response = await apiService.get('/fake');
      expect(response, fakeMockResponse);

      final response2 = await apiService.getRandom();
      expect(response2, randomMockResponse);
    });
  });
}
