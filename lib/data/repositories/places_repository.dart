import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../core/constants/api_keys.dart';
import '../models/place_model.dart';

class PlacesRepository {
  Future<List<PlaceModel>> searchPlaces(String query,
      {required String sessionToken}) async {
    log('sessionToken: $sessionToken');
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$googleApiKey&sessiontoken=$sessionToken';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['predictions'] as List)
          .map((json) => PlaceModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch place suggestions');
    }
  }
}
