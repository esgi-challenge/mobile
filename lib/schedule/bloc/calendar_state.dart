import 'package:flutter/material.dart';
import 'package:mobile/core/models/schedule.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;

  ScheduleLoaded({required this.schedule});
}

class ScheduleError extends ScheduleState {
  final String errorMessage;

  ScheduleError({required this.errorMessage});
}
