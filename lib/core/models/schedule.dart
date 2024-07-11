class Schedule {
  final int id;
  final DateTime date;
  final int duration;
  final String campus;
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
    final date =
        DateTime.fromMillisecondsSinceEpoch(json['schedule']['time'] * 1000);

    return Schedule(
      id: json['schedule']['id'],
      date: date,
      duration: json['schedule']['duration'] ?? 0,
      campus: json['campus']['name'],
      course: json['course']['name'],
      teacher: json['course']['teacher']['lastname'],
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
