part of 'home_bloc.dart';

/// {@template home_state}
/// HomeState base class
/// {@endtemplate}
sealed class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// {@template home_initial}
/// The initial state of HomeState
/// {@endtemplate}
class HomeInitial extends HomeState {
  /// {@macro home_initial}
  const HomeInitial() : super();
}

/// {@template home_loading}
/// The state when HomeState is loading
/// {@endtemplate}
class HomeLoading extends HomeState {
  /// {@macro home_loading}
  const HomeLoading();
}

/// {@template home_loaded}
/// The state when HomeState is loaded
/// {@endtemplate}
class HomeLoaded extends HomeState {
  /// {@macro home_loaded}
  const HomeLoaded({
    required this.coffee,
  });

  /// The coffee instance obtained from the repository
  final Coffee coffee;

  @override
  List<Object?> get props => [coffee];
}

/// {@template home_error}
/// The state when HomeState has an error
/// {@endtemplate}
class HomeError extends HomeState {
  /// {@macro home_error}
  const HomeError(
    this.errorMessage, {
    this.reason,
  });

  final String errorMessage;
  final HomeErrorReason? reason;

  @override
  List<Object?> get props => [
        errorMessage,
        reason,
      ];
}

enum HomeErrorReason {
  /// The server is unreachable.
  networkError,
}
