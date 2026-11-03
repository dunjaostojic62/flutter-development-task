import 'package:weather_app/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String city);
}