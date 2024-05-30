import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

part 'coffee_home_event.dart';
part 'coffee_home_state.dart';

class CoffeeHomeBloc extends Bloc<CoffeeHomeEvent, CoffeeHomeState> {
  CoffeeHomeBloc({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(const CoffeeHomeInitial()) {
    on<LoadRandomPhotoEvent>(_onLoadRandomPhotoEvent);
  }

  final CoffeeRepository _coffeeRepository;

  FutureOr<void> _onLoadRandomPhotoEvent(
    LoadRandomPhotoEvent event,
    Emitter<CoffeeHomeState> emit,
  ) async {
    emit(const CoffeeHomeLoading());

    try {
      final coffee = await _coffeeRepository.getRandomCoffee();

      emit(
        CoffeeHomeLoaded(
          coffee: coffee,
        ),
      );
    } on GetRandomCoffeeFailure catch (e) {
      emit(CoffeeHomeError(e.message));
    }
  }
}
