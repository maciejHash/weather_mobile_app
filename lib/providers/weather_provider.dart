import 'package:flutter/material.dart';

import '../models/city.dart';
import '../models/weather.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  final LocalStorageService _storageService = LocalStorageService();

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

      await _storageService.saveWeather(
        cityName: city!.name,
        country: city!.country,
        latitude: city!.latitude,
        longitude: city!.longitude,
        temperature: weather!.temperature,
        windSpeed: weather!.windSpeed,
      );
    } catch (e) {
      final localData = _storageService.getWeather();

      if (localData != null) {
        city = City(
          name: localData['cityName'],
          latitude: localData['latitude'],
          longitude: localData['longitude'],
          country: localData['country'],
        );

        weather = Weather(
          temperature: localData['temperature'],

          windSpeed: localData['windSpeed'],

          weatherCode: 0,

          dailyForecasts: [],
        );

        errorMessage = 'Brak Internetu - wyświetlono ostatnie zapisane dane';
      } else {
        errorMessage = 'Brak Internetu i brak zapisanych danych';
      }
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }
}
