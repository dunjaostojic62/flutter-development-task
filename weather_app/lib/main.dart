import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'weather/presentation/weather_page.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    ),
  );
}