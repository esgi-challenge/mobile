import 'package:intl/intl.dart';

class Project {
  final int id;
  final String title;
  final String course;
  final String teacher;
  final DateTime endDate;

  Project({
    required this.id,
    required this.title,
    required this.course,
    required this.teacher,
    required this.endDate,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    final endDate = DateFormat("dd-MM-yyyy").parse(json['endDate']);
    return Project(
      id: json['id'],
      title: json['title'],
      course: json['course']['name'],
      teacher: json['course']['teacher']['lastname'],
      endDate: endDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'course': course,
      'teacher': teacher,
      'endDate': endDate,
    };
  }
}