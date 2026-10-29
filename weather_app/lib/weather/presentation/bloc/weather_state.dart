import 'package:weather_app/weather/domain/entities/weather.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState{}

class WeatherLoading extends WeatherState{}

class WeatherLoaded extends WeatherState{
  final Weather weather;

  WeatherLoaded(this.weather);
}

class WeatherError extends WeatherState{}