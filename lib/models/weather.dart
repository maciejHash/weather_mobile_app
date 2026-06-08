class Weather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;

  Weather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];

    return Weather(
      temperature: (current['temperature'] as num).toDouble(),
      windSpeed: (current['windspeed'] as num).toDouble(),
      weatherCode: current['weathercode'],
    );
  }
}
