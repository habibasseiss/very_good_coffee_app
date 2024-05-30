import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';
import 'package:very_good_coffee_app/services/services.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  const testFilePath = 'https://apitest.dev/GhoCm_jVlXg_coffee.png';

  TestWidgetsFlutterBinding.ensureInitialized();

  final mockApiService = MockApiService();
  final apiCoffeeRepository = ApiCoffeeRepository(
    apiService: mockApiService,
  );

  group('Testing Coffee Repository', () {
    setUp(() {
      when(() => mockApiService.get('/random.json')).thenAnswer(
        (_) async => <String, dynamic>{
          'file': testFilePath,
        },
      );
    });
    test('Test get random coffee', () async {
      expect(
        await apiCoffeeRepository.getRandomCoffee(),
        isA<Coffee>().having(
          (c) => c.file,
          'file url',
          testFilePath,
        ),
      );
    });
  });
}
