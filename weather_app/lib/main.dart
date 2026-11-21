import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather/data/datasources/weather_remote_data_source.dart';
import 'weather/data/datasources/geocode_remote_ds.dart';
import 'weather/data/repositories/weather_repo_impl.dart';
import 'weather/presentation/bloc/weather_bloc.dart';
import 'weather/presentation/bloc/weather_event.dart';
import 'weather/presentation/bloc/weather_state.dart';
import 'weather/presentation/weather_page.dart';

void main() {
  final dataSource = WeatherRemoteDataSource();
  final geocodingDataSource = GeocodingRemoteDataSource();

  final repository = WeatherRepoImpl(
    dataSource,
    geocodingDataSource,
  );

  runApp(
    BlocProvider(
      create: (context) => WeatherBloc(repository)
        ..add(WeatherRequested('Novi Sad')),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final isDay = state is WeatherLoaded
            ? state.weather.isDay
            : true;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: isDay ? ThemeMode.light : ThemeMode.dark,
          home: const WeatherPage(),
        );
      },
    );
  }
}