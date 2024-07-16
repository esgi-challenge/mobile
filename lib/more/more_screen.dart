import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/collapsible/collapsible.dart';
import 'package:mobile/more/blocs/more_bloc.dart';
import 'package:mobile/more/blocs/more_event.dart';
import 'package:mobile/more/blocs/more_state.dart';
import 'package:mobile/more/services/more_service.dart';

class MoreCoursesScreen extends StatelessWidget {
  const MoreCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreBloc(MoreService())..add(LoadMore()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Matières",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(109, 53, 172, 1),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<MoreBloc, MoreState>(
                  builder: (context, state) {
                    if (state is MoreLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MoreLoaded) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            double average = note['notes'].fold(0, (sum, item) => sum + item['value']) / note['notes'].length;

                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                Collapsible(
                                  title: note['course'],
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            color: Colors.amber,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            note['teacher'],
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(109, 53, 172, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Notes:",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(109, 53, 172, 1),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          ...note['notes'].map<Widget>((noteDetail) {
                                            final projectName = noteDetail['project'].length > 20 ? '${noteDetail['project'].substring(0, 20)}...' : noteDetail['project'];

                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '$projectName: ',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color.fromRGBO(109, 53, 172, 1),
                                                    ),
                                                  ),
                                                  Text(
                                                    noteDetail['value'].toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color.fromRGBO(145, 103, 193, 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Moyenne: ${average.toStringAsFixed(2)}",
                                            textAlign: TextAlign.end,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(160, 161, 161, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is MoreNotFound) {
                      return const Center(child: Text("No data found"));
                    } else if (state is MoreError) {
                      return Center(child: Text("Error: ${state.errorMessage}"));
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}