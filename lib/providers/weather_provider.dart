import 'package:flutter/material.dart';

import '../models/city.dart';
import '../models/weather.dart';
import '../services/api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  City? city;
  Weather? weather;

  bool isLoading = false;

  String? errorMessage;

  Future<void> searchWeather(String cityName) async {
    try {
      isLoading = true;
      errorMessage = null;

      notifyListeners();

      city = await _apiService.searchCity(cityName);

      if (city == null) {
        errorMessage = 'Nie znaleziono miasta';

        isLoading = false;

        notifyListeners();

        return;
      }

      weather = await _apiService.getWeather(city!.latitude, city!.longitude);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
