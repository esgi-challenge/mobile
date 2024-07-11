import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/chat/blocs/channel_event.dart';
import 'package:mobile/chat/services/chat_service.dart';
import 'package:mobile/chat/blocs/channel_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/login/services/auth_service.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final ChatService chatService;
  List<dynamic>? originalChannels;
  List<dynamic>? originalChatters;

  ChannelBloc(this.chatService) : super(ChannelInitial()) {
    on<LoadChannels>((event, emit) async {
      emit(ChannelLoading());
      try {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(AuthService.jwt!);
        int userKind = decodedToken['user']['userKind'];

        final channels = await chatService.getChannels();

        dynamic chatters;

        if (userKind == 1) {
          chatters = await chatService.getStudents();
        } else if (userKind == 0) {
          chatters = await chatService.getTeachers();
        } else {
          chatters = [];
        }

        if (channels != null && channels.isNotEmpty) {
          originalChannels = channels;
          originalChatters = chatters;
          emit(ChannelLoaded(channels: channels, chatters: chatters!));
        } else if (chatters != null && chatters.isNotEmpty) {
          originalChatters = chatters;
          originalChannels ??= [];
          emit(ChannelLoaded(channels: originalChannels!, chatters: chatters));
        } else {
          originalChatters ??= [];
          originalChannels ??= [];
          emit(ChannelLoaded(
              channels: originalChannels!, chatters: originalChatters!));
        }
      } on Exception catch (e) {
        emit(ChannelError(errorMessage: e.toString()));
      }
    });

    on<SearchChatter>((event, emit) {
      if (originalChatters == null) return;

      final query = event.query.toLowerCase();
      final filteredChatters = originalChatters!.where((chatter) {
        return chatter['lastname'].toLowerCase().startsWith(query);
      }).toList();

      emit(ChannelLoaded(
          channels: originalChannels!, chatters: filteredChatters));
    });

    on<AddChannel>((event, emit) async {
      emit(ChannelLoading());
      try {
        final channel = await chatService.addChannel(event.chatterId);

        if (channel != null) {
          emit(ChannelAdded(channelId: channel['id']));
        }
      } on Exception catch (e) {
        originalChannels ??= [];
        emit(ChannelLoaded(
            channels: originalChannels!, chatters: originalChatters!));
      }
    });
  }
}
