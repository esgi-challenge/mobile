import 'package:flutter/material.dart';

@immutable
abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final int id;

  LoadSchedule(
    this.id,
  );
}
