import 'dart:convert';
import 'dart:typed_data';

import 'package:floor/floor.dart';

class ImageTypeConverter extends TypeConverter<Uint8List, String> {
  @override
  Uint8List decode(String databaseValue) {
    return base64.decode(databaseValue);
  }

  @override
  String encode(Uint8List value) {
    return base64.encode(value);
  }
}
