class DailyForecast {
  final String date;
  final double maxTemperature;
  final double minTemperature;

  DailyForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
  });
}

class Weather {
  final double temperature;
  final double windSpeed;
  final int weatherCode;

  final List<DailyForecast> dailyForecasts;

  Weather({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.dailyForecasts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];

    final daily = json['daily'];

    List<DailyForecast> forecasts = [];

    if (daily != null) {
      List dates = daily['time'];

      List maxTemps = daily['temperature_2m_max'];

      List minTemps = daily['temperature_2m_min'];

      for (int i = 0; i < dates.length; i++) {
        forecasts.add(
          DailyForecast(
            date: dates[i],
            maxTemperature: (maxTemps[i] as num).toDouble(),
            minTemperature: (minTemps[i] as num).toDouble(),
          ),
        );
      }
    }

    return Weather(
      temperature: (current['temperature'] as num).toDouble(),

      windSpeed: (current['windspeed'] as num).toDouble(),

      weatherCode: current['weathercode'],

      dailyForecasts: forecasts,
    );
  }
}
