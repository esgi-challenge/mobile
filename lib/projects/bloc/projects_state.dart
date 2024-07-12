import 'package:flutter/material.dart';
import 'package:mobile/core/models/project.dart';

@immutable
abstract class ProjectsState {}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;

  ProjectsLoaded({required this.projects});
}

class ProjectsLoading extends ProjectsState {}

class ProjectsError extends ProjectsState {
  final String errorMessage;

  ProjectsError({required this.errorMessage});
}
