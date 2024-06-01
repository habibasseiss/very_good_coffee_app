// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FavoritesStateCWProxy {
  FavoritesState coffees(List<Coffee> coffees);

  FavoritesState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FavoritesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FavoritesState(...).copyWith(id: 12, name: "My name")
  /// ````
  FavoritesState call({
    List<Coffee>? coffees,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFavoritesState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFavoritesState.copyWith.fieldName(...)`
class _$FavoritesStateCWProxyImpl implements _$FavoritesStateCWProxy {
  const _$FavoritesStateCWProxyImpl(this._value);

  final FavoritesState _value;

  @override
  FavoritesState coffees(List<Coffee> coffees) => this(coffees: coffees);

  @override
  FavoritesState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FavoritesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FavoritesState(...).copyWith(id: 12, name: "My name")
  /// ````
  FavoritesState call({
    Object? coffees = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return FavoritesState(
      coffees: coffees == const $CopyWithPlaceholder() || coffees == null
          ? _value.coffees
          // ignore: cast_nullable_to_non_nullable
          : coffees as List<Coffee>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $FavoritesStateCopyWith on FavoritesState {
  /// Returns a callable class that can be used as follows: `instanceOfFavoritesState.copyWith(...)` or like so:`instanceOfFavoritesState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FavoritesStateCWProxy get copyWith => _$FavoritesStateCWProxyImpl(this);
}
