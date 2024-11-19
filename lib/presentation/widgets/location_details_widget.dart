import 'package:flutter/material.dart';
import '../../domain/entities/location_details.dart';

class LocationDetailsWidget extends StatelessWidget {
  final LocationDetails details;

  const LocationDetailsWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Country: ${details.country}',
            style: const TextStyle(fontSize: 16.0)),
        Text('City: ${details.city}', style: const TextStyle(fontSize: 16.0)),
        Text('State: ${details.state}', style: const TextStyle(fontSize: 16.0)),
        Text('District: ${details.district}',
            style: const TextStyle(fontSize: 16.0)),
        Text('Street: ${details.street}',
            style: const TextStyle(fontSize: 16.0)),
        Text('ZIP Code: ${details.zipCode}',
            style: const TextStyle(fontSize: 16.0)),
      ],
    );
  }
}
