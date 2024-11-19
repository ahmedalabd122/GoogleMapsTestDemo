import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_test_task/core/utils/debouncer.dart';
import 'package:google_maps_test_task/domain/entities/location_details.dart';
import 'package:google_maps_test_task/presentation/cubits/map_cubit.dart';
import 'package:google_maps_test_task/presentation/screens/location_display_screen.dart';
import '../cubits/search_cubit.dart';
import '../../data/models/place_model.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (query) {
            Debouncer(milliseconds: 1000).call(() {
              context.read<SearchCubit>().searchPlaces(query);
            });
          },
          decoration: InputDecoration(
            hintText: 'Search for a location',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const LinearProgressIndicator();
            } else if (state is SearchLoaded) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.places.length,
                  itemBuilder: (context, index) {
                    final PlaceModel place = state.places[index];
                    return ListTile(
                      title: Text(place.name),
                      onTap: () async {
                        await context.read<MapCubit>().fetchLocationDetails(
                              place.placeId,
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationDisplayScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
