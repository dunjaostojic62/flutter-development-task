import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRemoteDataSource {

  Future<Map<String, dynamic>> getWeather() async {

      final url = Uri.https(
        'api.open-meteo.com',
        '/v1/forecast',
        {
          'latitude': '45.2671',
          'longitude': '19.8335',
          'current':
              'temperature_2m,apparent_temperature,wind_speed_10m,weather_code',
        },
      );

    final response = await http.get(url);

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else {
      throw Exception('Failed to load weather');
    }
  }
}