part of 'favorites_bloc.dart';

/// {@template favorites_state}
/// FavoritesState description
/// {@endtemplate}
class FavoritesState extends Equatable {
  /// {@macro favorites_state}
  const FavoritesState({
    this.coffees = const [],
    this.isLoading = false,
  });

  /// List of favorite coffees
  final List<Coffee> coffees;

  /// Indicates if favorites are loading
  final bool isLoading;

  /// Returns true if a coffee is set as favorite. This is determined by
  /// checking if the coffee's url is present in the list of favorite coffees.
  /// Full object comparison is not possible because the image id is not
  /// available if it's not saved in the database.
  bool isFavorite(Coffee coffee) =>
      coffees.map((e) => e.url).contains(coffee.url);

  @override
  List<Object> get props => [
        coffees,
        isLoading,
      ];

  /// Creates a copy of the current FavoritesState with property changes
  FavoritesState copyWith({
    List<Coffee>? coffees,
    bool? isLoading,
  }) {
    return FavoritesState(
      coffees: coffees ?? this.coffees,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
