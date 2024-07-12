import 'package:flutter/material.dart';
import 'package:mobile/core/models/schedule.dart';

@immutable
abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Schedule> schedules;

  AttendanceLoaded({required this.schedules});
}

class AttendanceLoading extends AttendanceState {}

class AttendanceError extends AttendanceState {
  final String errorMessage;

  AttendanceError({required this.errorMessage});
}
