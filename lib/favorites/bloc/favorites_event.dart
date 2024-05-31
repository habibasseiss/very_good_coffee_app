part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_favorites_event}
/// Event that is called when the favorites need to be loaded.
/// {@endtemplate}
class LoadFavoritesEvent extends FavoritesEvent {
  /// {@macro load_favorites_event}
  const LoadFavoritesEvent();
}

/// {@template add_favorite_coffee_event}
/// Event that is called when a coffee is added to favorites.
/// {@endtemplate}
class AddFavoriteCoffeeEvent extends FavoritesEvent {
  /// {@macro add_favorite_coffee_event}
  const AddFavoriteCoffeeEvent({required this.coffee});

  final Coffee coffee;

  @override
  List<Object> get props => [coffee];
}
