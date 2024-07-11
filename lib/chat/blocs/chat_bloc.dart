import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/chat/blocs/chat_event.dart';
import 'package:mobile/chat/blocs/chat_state.dart';
import 'package:mobile/chat/services/chat_service.dart';


class ChannelIdBloc extends Bloc<ChannelIdEvent, ChannelIdState> {
  final ChatService chatService;
  dynamic channelId;
  List<dynamic>? messages;

  ChannelIdBloc(this.chatService) : super(ChannelIdInitial()) {
    on<LoadChannelId>((event, emit) async {
      emit(ChannelIdLoading());
      try {
        final channelById = await chatService.getChannelById(event.id);

        if (channelById != null && channelById.isNotEmpty) {
          channelId = channelById;
          emit(ChannelIdLoaded(channelId: channelId));
        } else {
          emit(ChannelIdNotFound());
        }
      } on Exception catch (e) {
        emit(ChannelIdError(errorMessage: e.toString()));
      }
    });
  }
}