import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/weather/presentation/weather_page.dart';
import 'package:weather_app/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/weather/data/datasources/geocode_remote_ds.dart';
import 'package:weather_app/weather/data/repositories/weather_repo_impl.dart';

void main() {
  testWidgets('Weather page displays title', (tester) async {
    final dataSource = WeatherRemoteDataSource();
    final geocodingDataSource = GeocodingRemoteDataSource();
    final repository = WeatherRepoImpl(dataSource, geocodingDataSource);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => WeatherBloc(repository),
          child: const WeatherPage(),
        ),
      ),
    );

    expect(find.text('Weather'), findsOneWidget);
  });
}