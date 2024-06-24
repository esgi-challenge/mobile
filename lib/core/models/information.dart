class Information {
  final int id;
  final String title;
  final String description;
  final String date;

  Information({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
