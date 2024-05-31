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

  /// Returns true if a coffee is set as favorite
  bool isFavorite(Coffee coffee) => coffees.contains(coffee);

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
