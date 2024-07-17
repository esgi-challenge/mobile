import 'package:flutter/material.dart';
import 'package:mobile/core/models/information.dart';

enum InformationStatus { initial, loading, success, error }

@immutable
abstract class ProjectsState {}

class InformationLoad extends ProjectsState {
  final InformationStatus status;
  final List<Information>? informations;

  InformationLoad({this.status = InformationStatus.loading, this.informations});
}

class InformationError extends ProjectsState {
  final String errorMessage;

  InformationError({required this.errorMessage});
}
