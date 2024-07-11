import 'package:flutter/material.dart';
import 'package:mobile/core/models/schedule.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Schedule schedule;
  final bool signature;

  ScheduleLoaded({
    required this.schedule,
    required this.signature,
  });
}

class ScheduleError extends ScheduleState {
  final String errorMessage;

  ScheduleError({required this.errorMessage});
}
