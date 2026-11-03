import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/presentation/bloc/weather_event.dart';

import 'weather/data/datasources/weather_remote_data_source.dart';
import 'weather/data/repositories/weather_repo_impl.dart';
import 'weather/presentation/weather_page.dart';
import 'weather/presentation/bloc/weather_bloc.dart';
import 'weather/data/datasources/geocode_remote_ds.dart';

void main(){

  final dataSource = WeatherRemoteDataSource();
  final geocodingDataSource = GeocodingRemoteDataSource();
  final repository = WeatherRepoImpl(dataSource, geocodingDataSource,);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context)=> WeatherBloc(repository)
          ..add(WeatherRequested('Novi Sad')),
        child: WeatherPage(),
      ),
    ),
  );
}