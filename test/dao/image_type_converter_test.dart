import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/dao/image_type_converter.dart';

void main() {
  group('ImageTypeConverter', () {
    late ImageTypeConverter converter;

    setUp(() {
      converter = ImageTypeConverter();
    });

    test('decode converts base64 string to Uint8List', () {
      const base64String = 'aGVsbG8gd29ybGQ=';
      final expectedBytes = utf8.encode('hello world');

      final result = converter.decode(base64String);

      expect(result, expectedBytes);
    });

    test('encode converts Uint8List to base64 string', () {
      final bytes = utf8.encode('hello world');
      const expectedBase64String = 'aGVsbG8gd29ybGQ=';

      final result = converter.encode(bytes);

      expect(result, expectedBase64String);
    });

    test('encode and decode are inverse operations', () {
      final bytes = utf8.encode('hello world');

      final base64String = converter.encode(bytes);
      final result = converter.decode(base64String);

      expect(result, bytes);
    });
  });
}
