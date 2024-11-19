import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/location_details.dart';
import '../../domain/usecases/reverse_geocoding.dart';

abstract class MapState {
  MapState({this.lat, this.lang});

  final double? lat;
  final double? lang;
}

class MapInitial extends MapState {
  @override
  final lang = -122.4194;
  @override
  final lat = 37.7749;
}

class MapUpdated extends MapState {
  @override
  final double lat;
  @override
  final double lang;

  MapUpdated({
    required this.lat,
    required this.lang,
  });
}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LocationDetails locationDetails;

  MapLoaded(this.locationDetails);
}

class MapError extends MapState {
  final String errorMessage;

  MapError(this.errorMessage);
}

class MapCubit extends Cubit<MapState> {
  final ReverseGeocodingUseCase reverseGeocoding;

  MapCubit(this.reverseGeocoding) : super(MapInitial());

  Future<void> fetchLocationDetails(String placeId) async {
    emit(MapLoading());
    try {
      final details = await reverseGeocoding.execute(placeId);
      log(details.city.toString());
      emit(MapLoaded(details));
    } catch (e) {
      emit(MapError('Failed to load location details: ${e.toString()}'));
    }
  }

  void updatePosition(double lang, double lat) {
    emit(MapLoading());
    emit(
      MapUpdated(lat: lat, lang: lang),
    );
  }
}
