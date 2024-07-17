import 'package:intl/intl.dart';
import 'package:mobile/core/models/document.dart';

class Project {
  final int id;
  final String title;
  final String course;
  final String teacher;
  final DateTime endDate;
  final Document document;

  Project({
    required this.id,
    required this.title,
    required this.course,
    required this.teacher,
    required this.endDate,
    required this.document,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    final endDate = DateFormat("dd-MM-yyyy").parse(json['endDate']);

    return Project(
      id: json['id'],
      title: json['title'],
      course: json['course']['name'],
      teacher: json['course']['teacher']['lastname'],
      endDate: endDate,
      document: Document.fromJson(json['document']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'course': course,
      'teacher': teacher,
      'endDate': endDate,
      'document': document,
    };
  }
}
