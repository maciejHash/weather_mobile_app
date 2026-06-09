import 'package:flutter/material.dart';

import '../models/weather.dart';
import 'package:intl/intl.dart';
import '../utils/weather_code_mapper.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsScreen({super.key, required this.weather});

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('EEEE, d MMMM', 'pl_PL');
      return formatter.format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prognoza na 7 dni"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: weather.dailyForecasts.length,
        itemBuilder: (context, index) {
          final forecast = weather.dailyForecasts[index];
          final colorScheme = Theme.of(context).colorScheme;
          final isToday = index == 0;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: isToday ? 8 : 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: isToday
                    ? LinearGradient(
                        colors: [
                          colorScheme.primary.withOpacity(0.1),
                          colorScheme.secondary.withOpacity(0.05),
                        ],
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Date Section
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(forecast.date),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isToday
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: isToday
                                  ? colorScheme.primary
                                  : Colors.black87,
                            ),
                          ),
                          if (isToday)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Dzisiaj',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Temperature Range Section
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${forecast.maxTemperature.toStringAsFixed(0)}°',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${forecast.minTemperature.toStringAsFixed(0)}°',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'maks / min',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
