import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test_task/presentation/cubits/map_cubit.dart';
import '../../domain/entities/location_details.dart';
import '../widgets/location_details_widget.dart';

class LocationDisplayScreen extends StatelessWidget {
  const LocationDisplayScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: BlocBuilder<MapCubit, MapState>(builder: (context, state) {
        final LocationDetails locationDetails;
        if (state is MapLoaded) {
          locationDetails = state.locationDetails;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250.0,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        locationDetails.latitude, locationDetails.longitude),
                    zoom: 16.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: LatLng(
                          locationDetails.latitude, locationDetails.longitude),
                    ),
                  },
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: LocationDetailsWidget(details: locationDetails),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
