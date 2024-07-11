import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile/chat/blocs/channel_event.dart';
import 'package:mobile/chat/blocs/channel_state.dart';
import 'package:mobile/chat/services/chat_service.dart';
import 'package:mobile/chat/blocs/channel_bloc.dart';
import 'package:mobile/login/services/auth_service.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChannelBloc(ChatService())..add(LoadChannels()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ChannelBloc, ChannelState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discussions",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(109, 53, 172, 1)),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (state is ChannelLoaded && state.chatters.isNotEmpty) {
                              _showDiscussDialog(context, state.chatters);
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(249, 178, 53, 1),
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(249, 178, 53, 0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: BlocBuilder<ChannelBloc, ChannelState>(
                    builder: (context, state) {
                      if (state is ChannelAdded) {
                        GoRouter.of(context).go('/chat/${state.channelId}');
                      } 
                      if (state is ChannelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ChannelLoaded) {
                        Map<String, dynamic> decodedToken = JwtDecoder.decode(AuthService.jwt!);
                        int userId = decodedToken['user']['id'];

                        return ListView.builder(
                          itemCount: state.channels.length,
                          itemBuilder: (context, index) {
                            final channel = state.channels[index];
                            final chatUser = (channel['firstUser']['id'] == userId)
                                ? channel['secondUser']
                                : channel['firstUser'];
                            final chatUserName = '${chatUser['firstname']} ${chatUser['lastname']}';
                            String lastMessage = "Aucun message envoyé";
                            String formattedDate = '';

                            if (channel['messages'].isNotEmpty) {
                              final lastMessageData = channel['messages'].last;
                              lastMessage = lastMessageData['content'];
                              if (lastMessage.length > 40) {
                                lastMessage = '${lastMessage.substring(0, 40)}...';
                              }
                              DateTime parsedDate = DateTime.parse(lastMessageData['createdAt']);
                              formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
                            }

                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(50, 50, 50, 0.1),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(0, 3), 
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    chatUserName,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromRGBO(109, 53, 172, 1)),
                                                  ),
                                                  if (formattedDate.isNotEmpty)
                                                    Text(
                                                      formattedDate,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color.fromRGBO(247, 159, 2, 1)),
                                                    ),
                                                ]),
                                            Text(
                                              lastMessage,
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(141, 143, 142, 1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                GoRouter.of(context).push('/chat/${channel['id']}');
                              },
                            );
                          },
                        );
                      } else if (state is ChannelError) {
                        return Center(child: Text('Erreur: ${state.errorMessage}'));
                      } else {
                        return const Center(child: Text('Chat'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDiscussDialog(BuildContext context, List<dynamic> chatters) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<ChannelBloc>(context),
          child: Builder(
            builder: (context) {
              return AlertDialog(
                title: const Text('Discuter'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Rechercher quelqu\'un',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<ChannelBloc>().add(LoadChannels());
                              },
                            ),
                          ),
                          onChanged: (query) {
                            context.read<ChannelBloc>().add(SearchChatter(query));
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: BlocBuilder<ChannelBloc, ChannelState>(
                          builder: (context, state) {
                            if (state is ChannelLoaded) {
                              if (state.chatters.isEmpty) {
                                return const Center(child: Text('Personne avec qui chatter'));
                              } else {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columnSpacing: 20.0,
                                    columns: const [
                                      DataColumn(label: Text('Prénom')),
                                      DataColumn(label: Text('Nom')),
                                      DataColumn(label: Text(''))
                                    ],
                                    rows: state.chatters.map<DataRow>((chatter) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            SizedBox(
                                              width: 70,
                                              child: Text(
                                                chatter['firstname'],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              width: 70,
                                              child: Text(
                                                chatter['lastname'],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                _searchController.clear();
                                                context.read<ChannelBloc>().add(AddChannel(chatter['id']));
                                                Navigator.of(context).pop();
                                              },
                                              child: const HeroIcon(
                                                HeroIcons.chatBubbleOvalLeft,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                );
                              }
                            } else {
                              return const Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Fermer', style: TextStyle(color: Colors.red)),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}