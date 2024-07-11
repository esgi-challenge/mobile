import 'package:flutter/material.dart';

@immutable
abstract class ChannelEvent {}

class LoadChannels extends ChannelEvent {}

class AddChannel extends ChannelEvent {
  final int chatterId;

  AddChannel(this.chatterId);
}

class SearchChatter extends ChannelEvent {
  final String query;

  SearchChatter(this.query);
}