class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String condition;
  final bool isDay;

  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.isDay,
  });
}