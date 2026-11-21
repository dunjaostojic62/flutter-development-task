import "package:weather_app/weather/domain/hourly_weather.dart";

class Weather {
  final String city;
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final String condition;
  final bool isDay;
  final List<HourlyWeather> hourlyForecast;

  const Weather({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.condition,
    required this.isDay,
    required this.hourlyForecast,
  });
}