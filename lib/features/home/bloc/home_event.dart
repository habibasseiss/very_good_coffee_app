part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_random_coffee_event}
/// Event that is called when a random coffee photo needs to be loaded.
/// {@endtemplate}
class LoadRandomCoffeeEvent extends HomeEvent {
  /// {@macro load_random_coffee_event}
  const LoadRandomCoffeeEvent();
}
