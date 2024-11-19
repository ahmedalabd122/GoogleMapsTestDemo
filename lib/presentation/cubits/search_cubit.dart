import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_test_task/data/repositories/places_repository.dart';
import '../../data/models/place_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<PlaceModel> places;

  SearchLoaded(this.places);
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}

class SearchCubit extends Cubit<SearchState> {
  final PlacesRepository? placesRepository = PlacesRepository();
  final String? sessionToken;

  SearchCubit({this.sessionToken}) : super(SearchInitial());

  void searchPlaces(String query) async {
    if (query.isEmpty) return;
    emit(SearchLoading());
    try {
      log('query: $query');
      final places = await placesRepository?.searchPlaces(query,
          sessionToken: sessionToken ?? '');

      log('places: $places');
      emit(SearchLoaded(places ?? []));
    } catch (e) {
      emit(SearchError('Failed to fetch search results: ${e.toString()}'));
    }
  }
}
