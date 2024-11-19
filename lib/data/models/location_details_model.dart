import '../../domain/entities/location_details.dart';

class LocationDetailsModel extends LocationDetails {
  LocationDetailsModel({
    required super.latitude,
    required super.longitude,
    required super.country,
    required super.city,
    required super.state,
    required super.district,
    required super.street,
    required super.zipCode,
  });

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    final addressComponents = json['address_components'] as List;

    String getComponent(String type) {
      try {
        return addressComponents
            .firstWhere((c) => (c['types'] as List).contains(type))['long_name']
            .toString();
      } catch (e) {
        return 'Unknown';
      }
    }

    return LocationDetailsModel(
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      country: getComponent('country'),
      city: getComponent('locality'),
      state: getComponent('administrative_area_level_1'),
      district: getComponent('sublocality'),
      street: getComponent('route'),
      zipCode: getComponent('postal_code'),
    );
  }
}
