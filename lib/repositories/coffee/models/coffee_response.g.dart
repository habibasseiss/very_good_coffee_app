// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CoffeeResponseCWProxy {
  CoffeeResponse file(String file);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CoffeeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CoffeeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CoffeeResponse call({
    String? file,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCoffeeResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCoffeeResponse.copyWith.fieldName(...)`
class _$CoffeeResponseCWProxyImpl implements _$CoffeeResponseCWProxy {
  const _$CoffeeResponseCWProxyImpl(this._value);

  final CoffeeResponse _value;

  @override
  CoffeeResponse file(String file) => this(file: file);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CoffeeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CoffeeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CoffeeResponse call({
    Object? file = const $CopyWithPlaceholder(),
  }) {
    return CoffeeResponse(
      file: file == const $CopyWithPlaceholder() || file == null
          ? _value.file
          // ignore: cast_nullable_to_non_nullable
          : file as String,
    );
  }
}

extension $CoffeeResponseCopyWith on CoffeeResponse {
  /// Returns a callable class that can be used as follows: `instanceOfCoffeeResponse.copyWith(...)` or like so:`instanceOfCoffeeResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CoffeeResponseCWProxy get copyWith => _$CoffeeResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeResponse _$CoffeeResponseFromJson(Map<String, dynamic> json) =>
    CoffeeResponse(
      file: json['file'] as String,
    );

Map<String, dynamic> _$CoffeeResponseToJson(CoffeeResponse instance) =>
    <String, dynamic>{
      'file': instance.file,
    };
