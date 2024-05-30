part of 'coffee_home_bloc.dart';

abstract class CoffeeHomeEvent extends Equatable {
  const CoffeeHomeEvent();

  @override
  List<Object> get props => [];
}

/// {@template load_random_photo_event}
/// Event that is called when a random coffee photo needs to be loaded.
/// {@endtemplate}
class LoadRandomPhotoEvent extends CoffeeHomeEvent {
  /// {@macro load_random_photo_event}
  const LoadRandomPhotoEvent();
}
