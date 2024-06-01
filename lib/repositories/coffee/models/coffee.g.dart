// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CoffeeCWProxy {
  Coffee image(Uint8List image);

  Coffee url(String url);

  Coffee id(int? id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coffee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coffee(...).copyWith(id: 12, name: "My name")
  /// ````
  Coffee call({
    Uint8List? image,
    String? url,
    int? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCoffee.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCoffee.copyWith.fieldName(...)`
class _$CoffeeCWProxyImpl implements _$CoffeeCWProxy {
  const _$CoffeeCWProxyImpl(this._value);

  final Coffee _value;

  @override
  Coffee image(Uint8List image) => this(image: image);

  @override
  Coffee url(String url) => this(url: url);

  @override
  Coffee id(int? id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Coffee(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Coffee(...).copyWith(id: 12, name: "My name")
  /// ````
  Coffee call({
    Object? image = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return Coffee(
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as Uint8List,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
    );
  }
}

extension $CoffeeCopyWith on Coffee {
  /// Returns a callable class that can be used as follows: `instanceOfCoffee.copyWith(...)` or like so:`instanceOfCoffee.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CoffeeCWProxy get copyWith => _$CoffeeCWProxyImpl(this);
}
