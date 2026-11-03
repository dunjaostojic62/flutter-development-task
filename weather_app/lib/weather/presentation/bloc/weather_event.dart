abstract class WeatherEvent {}

class WeatherRequested extends WeatherEvent{
  final String city;

  WeatherRequested(this.city);
}

class WeatherRefreshed extends WeatherEvent{
  final String city;

  WeatherRefreshed(this.city);
}