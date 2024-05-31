import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_coffee_app/repositories/coffee/models/models.dart';
import 'package:very_good_coffee_app/repositories/favorites/favorites.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required FavoritesRepository favoritesRepository,
  })  : _favoritesRepository = favoritesRepository,
        super(const FavoritesState()) {
    on<LoadFavoritesEvent>(_onLoadFavoritesEvent);
    on<AddFavoriteCoffeeEvent>(_onAddFavoriteCoffeeEvent);
  }

  final FavoritesRepository _favoritesRepository;

  FutureOr<void> _onLoadFavoritesEvent(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final coffees = await _favoritesRepository.getFavorites();

    emit(
      state.copyWith(
        coffees: coffees,
        isLoading: false,
      ),
    );
  }

  FutureOr<void> _onAddFavoriteCoffeeEvent(
    AddFavoriteCoffeeEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    await _favoritesRepository.addFavorite(coffee: event.coffee);
  }
}