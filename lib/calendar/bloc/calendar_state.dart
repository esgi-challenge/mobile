import 'package:flutter/material.dart';
import 'package:mobile/core/models/schedule.dart';

@immutable
abstract class CalendarState {}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<Schedule> schedules;

  CalendarLoaded({required this.schedules});
}

class CalendarError extends CalendarState {
  final String errorMessage;

  CalendarError({required this.errorMessage});
}
