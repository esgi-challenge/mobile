import 'package:mobile/core/models/campus.dart';

class Schedule {
  final int id;
  final DateTime date;
  final int duration;
  final Campus campus;
  final String course;
  final String teacher;

  Schedule({
    required this.id,
    required this.date,
    required this.duration,
    required this.campus,
    required this.course,
    required this.teacher,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final date = DateTime.fromMillisecondsSinceEpoch(
        (json['schedule']?['time'] ?? json['time']) * 1000);

    return Schedule(
      id: json['schedule']?['id'] ?? json['id'],
      date: date,
      duration: json['schedule']?['duration'] ?? json['duration'] ?? 0,
      campus: Campus.fromJson(json['schedule']?['campus'] ?? json['campus']),
      course:
          json['course']['name'] ?? json['schedule']?['course']['name'] ?? "",
      teacher: json['schedule']?['course']['teacher']['lastname'] ??
          json['course']['teacher']['lastname'] ??
          "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'duration': duration,
    };
  }
}
