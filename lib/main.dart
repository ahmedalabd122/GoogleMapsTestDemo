import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_test_task/data/repositories/places_repository.dart';
import 'package:google_maps_test_task/presentation/cubits/map_cubit.dart';
import 'package:google_maps_test_task/presentation/cubits/search_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'presentation/screens/map_screen.dart';
import 'data/repositories/geocoding_repository.dart';
import 'domain/usecases/reverse_geocoding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  if (!await Permission.location.isGranted) {
    await Permission.location.request();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final geocodingRepository = GeocodingRepository();
    final reverseGeocodingUseCase =
        ReverseGeocodingUseCase(geocodingRepository);
    final PlacesRepository placesRepository = PlacesRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MapCubit(reverseGeocodingUseCase)),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: const MaterialApp(
        title: 'Flutter Google Maps',
        home: MapScreen(),
      ),
    );
  }
}
