import 'dart:convert';
import 'dart:typed_data';

import 'package:floor/floor.dart';

class ImageTypeConverter extends TypeConverter<Uint8List?, String?> {
  @override
  Uint8List? decode(String? databaseValue) {
    if (databaseValue != null) {
      return base64.decode(databaseValue);
    }

    return null;
  }

  @override
  String? encode(Uint8List? value) {
    if (value != null) {
      return base64.encode(value);
    }

    return null;
  }
}
