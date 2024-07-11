abstract class ChannelState {}

class ChannelInitial extends ChannelState {}

class ChannelLoading extends ChannelState {}

class ChannelLoaded extends ChannelState {
  final List<dynamic> channels;
  final List<dynamic> chatters;

  ChannelLoaded({required this.channels, required this.chatters});
}

class ChannelNotFound extends ChannelState {
  final List<dynamic> chatters;

  ChannelNotFound({required this.chatters});
}

class ChannelAdded extends ChannelState {
  final int channelId;

  ChannelAdded({required this.channelId});
}

class ChannelError extends ChannelState {
  final String errorMessage;

  ChannelError({required this.errorMessage});
}