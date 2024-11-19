import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/constants/api_keys.dart';
import '../models/location_details_model.dart';

class GeocodingRepository {
  final Dio dio = Dio();

  Future<LocationDetailsModel> getPlaceDetails(String placeId) async {
    final response = await dio.get(
      'https://maps.googleapis.com/maps/api/geocode/json',
      queryParameters: {
        'place_id': placeId,
        'key': googleApiKey,
      },
    );
    log('response: ${response.data}');
    return LocationDetailsModel.fromJson(response.data['results'][0]);
  }
}
