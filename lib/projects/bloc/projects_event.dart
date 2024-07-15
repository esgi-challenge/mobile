import 'package:flutter/material.dart';

@immutable
abstract class ProjectsEvent {}

class ProjectsInit extends ProjectsEvent {}

class GroupQuit extends ProjectsEvent {
  final int projectId;

  GroupQuit(
    this.projectId,
  );
}

class GroupJoin extends ProjectsEvent {
  final int groupId;
  final int projectId;

  GroupJoin(
    this.groupId,
    this.projectId,
  );
}

class GroupLoad extends ProjectsEvent {
  final int id;

  GroupLoad(
    this.id,
  );
}
