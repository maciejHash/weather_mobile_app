class City {
  final String name;
  final double latitude;
  final double longitude;
  final String country;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      country: json['country'] ?? '',
    );
  }
}
