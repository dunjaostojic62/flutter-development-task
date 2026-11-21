import 'package:weather_app/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/weather/domain/entities/weather.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/data/datasources/geocode_remote_ds.dart';
import 'package:weather_app/weather/domain/hourly_weather.dart';

class WeatherRepoImpl  implements WeatherRepository{

  final WeatherRemoteDataSource remoteDataSource;
  final GeocodingRemoteDataSource geocodingDataSource;

  WeatherRepoImpl(this.remoteDataSource, this.geocodingDataSource);

  @override
  Future<Weather> getWeather(String city) async {
    final location = await geocodingDataSource.getCity(city);
    final latitude = (location['latitude'] as num).toDouble();
    final longitude = (location['longitude'] as num).toDouble();

    final data = await remoteDataSource.getWeather(latitude, longitude,);
    final current = data['current'] as Map<String, dynamic>;
    final hourly = data['hourly'] as Map<String, dynamic>;

    final times = hourly['time'] as List<dynamic>;
    final temperatures = hourly['temperature_2m'] as List<dynamic>;
    final weatherCodes = hourly['weather_code'] as List<dynamic>;
    final isDayValues = hourly['is_day'] as List<dynamic>;

    final List<HourlyWeather> hourlyForecast = [];
    for (int i = 0; i < times.length; i++) {
      final forecast = HourlyWeather(
        time: DateTime.parse(times[i] as String),
        temperature: (temperatures[i] as num).toDouble(),
        condition: weatherCodeToDescription(weatherCodes[i] as int),
        isDay: isDayValues[i] == 1,
      );
      hourlyForecast.add(forecast);
    }

    final weather = Weather(
      city: location['name'] as String,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      condition: weatherCodeToDescription(
        current['weather_code'] as int,
      ),
      isDay: current['is_day'] == 1,
      hourlyForecast: hourlyForecast,
    );

  return weather;
  }
}

String weatherCodeToDescription(int code) {
  return switch (code) {
    0 => 'Clear sky',
    1 => 'Mainly clear',
    2 => 'Partly cloudy',
    3 => 'Overcast',
    45 || 48 => 'Fog',
    51 || 53 || 55 || 56 || 57 => 'Drizzle',
    61 || 63 || 65 || 66 || 67 => 'Rain',
    71 || 73 || 75 || 77 || 85 || 86 => 'Snow',
    80 || 81 || 82 => 'Rain showers',
    95 || 96 || 99 => 'Thunderstorm',
    _ => 'Unknown',
  };
}

