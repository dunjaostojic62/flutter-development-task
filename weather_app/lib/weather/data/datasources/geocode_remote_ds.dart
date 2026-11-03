import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingRemoteDataSource {
  Future<Map<String, dynamic>> getCity(String city) async {
    final url = Uri.https(
      'geocoding-api.open-meteo.com',
      '/v1/search',
      {
        'name': city,
        'count': '1',
      },
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to find city');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final results = data['results'] as List<dynamic>?;

    if (results == null || results.isEmpty) {
      throw Exception('City not found');
    }

    return results.first as Map<String, dynamic>;
  }
}