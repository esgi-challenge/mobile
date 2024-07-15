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
    return Campus(
      name: json['name'],
      lat: json['latitude'],
      lon: json['longitude'],
    );
  }
}
