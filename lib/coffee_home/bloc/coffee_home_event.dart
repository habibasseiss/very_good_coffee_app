part of 'coffee_home_bloc.dart';

abstract class CoffeeHomeEvent extends Equatable {
  const CoffeeHomeEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_random_coffee_event}
/// Event that is called when a random coffee photo needs to be loaded.
/// {@endtemplate}
class LoadRandomCoffeeEvent extends CoffeeHomeEvent {
  /// {@macro load_random_coffee_event}
  const LoadRandomCoffeeEvent();
}

/// {@template like_coffee_event}
/// Event that is called when a coffee is liked.
/// {@endtemplate}
class LikeCoffeeEvent extends CoffeeHomeEvent {
  /// {@macro like_coffee_event}
  const LikeCoffeeEvent();
}
