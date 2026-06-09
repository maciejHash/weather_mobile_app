import 'package:hive/hive.dart';

class LocalStorageService {
  final Box box = Hive.box('weatherBox');

  Future<void> saveWeather({
    required String cityName,
    required String country,
    required double latitude,
    required double longitude,
    required double temperature,
    required double windSpeed,
  }) async {
    await box.put('weather_data', {
      'cityName': cityName,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'temperature': temperature,
      'windSpeed': windSpeed,
    });
  }

  Map<String, dynamic>? getWeather() {
    final data = box.get('weather_data');

    if (data == null) {
      return null;
    }

    return Map<String, dynamic>.from(data);
  }
}
