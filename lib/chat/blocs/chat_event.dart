import 'package:flutter/material.dart';

@immutable
abstract class ChannelIdEvent {}

class LoadChannelId extends ChannelIdEvent {
  final int id;

  LoadChannelId(this.id);
}