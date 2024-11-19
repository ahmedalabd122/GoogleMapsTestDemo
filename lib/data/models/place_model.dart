import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    required super.name,
    required super.placeId,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['description'],
      placeId: json['place_id'],
    );
  }
}
