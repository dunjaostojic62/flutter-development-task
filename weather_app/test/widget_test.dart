import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/weather/presentation/weather_page.dart';
import 'package:weather_app/weather/presentation/bloc/weather_bloc.dart';

void main() {
  testWidgets('Weather page displays title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => WeatherBloc(),
          child: const WeatherPage(),
        ),
      ),
    );

    expect(find.text('Weather'), findsOneWidget);
  });
}