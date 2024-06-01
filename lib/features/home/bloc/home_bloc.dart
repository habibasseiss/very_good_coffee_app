import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/repositories/coffee/coffee.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required CoffeeRepository coffeeRepository,
  })  : _coffeeRepository = coffeeRepository,
        super(const HomeInitial()) {
    on<LoadRandomCoffeeEvent>(_onLoadRandomPhotoEvent);
  }

  final CoffeeRepository _coffeeRepository;

  FutureOr<void> _onLoadRandomPhotoEvent(
    LoadRandomCoffeeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      final coffee = await _coffeeRepository.getRandomCoffee();

      emit(
        HomeLoaded(
          coffee: coffee,
        ),
      );
    } on GetRandomCoffeeFailure catch (e) {
      emit(
        switch (e.reason) {
          GetRandomCoffeeFailureReason.networkError => const HomeError(
              'Network error',
              reason: HomeErrorReason.networkError,
            ),
          _ => HomeError(e.message),
        },
      );
    }
  }
}
