import 'package:flinq/flinq.dart';
import 'package:mobile/core/models/member.dart';

class Group {
  final int id;
  final List<Member> members;
  final bool joined;

  Group({
    required this.id,
    required this.members,
    required this.joined,
  });

  factory Group.fromJson(Map<String, dynamic> json, dynamic uid) {
    var joined = false;
    final List<Member> members = [];

    for (var member in json['members']) {
      if (uid == member['id']) {
        joined = true;
      }

      members.add(
        Member(
          name: "${member['firstname']} ${member['lastname']}",
          className: member['class']['name'],
        ),
      );
    }

    return Group(id: json['group'], members: members, joined: joined);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members,
    };
  }
}
