import '../../data/repositories/geocoding_repository.dart';
import '../entities/location_details.dart';

class ReverseGeocodingUseCase {
  final GeocodingRepository repository;

  ReverseGeocodingUseCase(this.repository);

  Future<LocationDetails> execute(String placeId) async {
    return await repository.getPlaceDetails(placeId);
  }
}
