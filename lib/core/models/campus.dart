class Campus {
  final String name;
  final double lat;
  final double lon;

  Campus({
    required this.name,
    required this.lat,
    required this.lon,
  });

  factory Campus.fromJson(Map<String, dynamic> json) {
    try {
      return Campus(
        name: json['name'],
        lat: json['latitude'],
        lon: json['longitude'],
      );
    } catch (e) {
      return Campus(
        name: "Inconnu",
        lat: 0.0,
        lon: 0.0,
      );
    }
  }
}
