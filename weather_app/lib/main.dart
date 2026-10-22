import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather/presentation/weather_page.dart';
import 'weather/presentation/bloc/weather_bloc.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context)=> WeatherBloc(),
        child: WeatherPage(),
      ),
    ),
  );
}