import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test_task/presentation/screens/location_display_screen.dart';
import 'package:google_maps_test_task/presentation/widgets/search_bar.dart';
import '../cubits/map_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double lang = -122.4194, lat = 37.7749;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: Stack(
        children: [
          BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              if (state is MapLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GoogleMap(
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  minMaxZoomPreference: const MinMaxZoomPreference(3, 20),
                  onTap: (LatLng position) async {
                    lang = position.longitude;
                    lat = position.latitude;
                    context.read<MapCubit>().updatePosition(lang, lat);
                    log('Position: $position');
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, lang),
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('selected'),
                      position: LatLng(lat, lang),
                    ),
                  },
                  onLongPress: (position) {
                    lang = position.longitude;
                    lat = position.latitude;
                    context.read<MapCubit>().updatePosition(lang, lat);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LocationDisplayScreen();
                      },
                    ));
                  },
                );
              }
            },
          ),
          const Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: CustomSearchBar(),
          ),
        ],
      ),
    );
  }
}
