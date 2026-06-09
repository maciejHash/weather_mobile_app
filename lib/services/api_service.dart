import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/city.dart';
import '../models/weather.dart';

class ApiService {
  Future<City?> searchCity(String cityName) async {
    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=1',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Błąd pobierania miasta');
    }

    final data = jsonDecode(response.body);

    if (data['results'] == null) {
      return null;
    }

    return City.fromJson(data['results'][0]);
  }

  Future<Weather> getWeather(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&current_weather=true'
      '&daily=temperature_2m_max,temperature_2m_min'
      '&timezone=auto',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Błąd pobierania pogody');
    }

    final data = jsonDecode(response.body);

    return Weather.fromJson(data);
  }
}
