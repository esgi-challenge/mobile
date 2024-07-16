import 'package:intl/intl.dart';

class Document {
  final bool administrative;
  final String name;
  final String path;
  final DateTime date;

  Document({
    required this.name,
    required this.administrative,
    required this.path,
    required this.date,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      date: DateTime.parse(json['createdAt']),
      name: json['name'],
      path: json['path'],
      administrative: json['course']['id'] == 0,
    );
  }
}
