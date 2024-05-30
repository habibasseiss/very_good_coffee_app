part of 'coffee_home_bloc.dart';

/// {@template coffee_home_state}
/// CoffeeHomeState base class
/// {@endtemplate}
sealed class CoffeeHomeState extends Equatable {
  /// {@macro coffee_home_state}
  const CoffeeHomeState();

  @override
  List<Object?> get props => [];
}

/// {@template coffee_home_initial}
/// The initial state of CoffeeHomeState
/// {@endtemplate}
class CoffeeHomeInitial extends CoffeeHomeState {
  /// {@macro coffee_home_initial}
  const CoffeeHomeInitial() : super();
}

/// {@template coffee_home_loading}
/// The state when CoffeeHomeState is loading
/// {@endtemplate}
class CoffeeHomeLoading extends CoffeeHomeState {
  /// {@macro coffee_home_loading}
  const CoffeeHomeLoading();
}

/// {@template coffee_home_loaded}
/// The state when CoffeeHomeState is loaded
/// {@endtemplate}
class CoffeeHomeLoaded extends CoffeeHomeState {
  /// {@macro coffee_home_loaded}
  const CoffeeHomeLoaded({
    required this.coffee,
  });

  /// The coffee instance obtained from the repository
  final Coffee coffee;

  @override
  List<Object?> get props => [coffee];
}

/// {@template coffee_home_error}
/// The state when CoffeeHomeState has an error
/// {@endtemplate}
class CoffeeHomeError extends CoffeeHomeState {
  /// {@macro coffee_home_error}
  const CoffeeHomeError(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
