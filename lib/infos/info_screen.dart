import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/models/information.dart';
import 'package:mobile/infos/blocs/informations_bloc.dart';
import 'package:mobile/infos/blocs/informations_event.dart';
import 'package:mobile/infos/blocs/informations_state.dart';

const months = [
  "Janvier",
  "Fevrier",
  "Mars",
  "Avril",
  "Mail",
  "Juin",
  "Juillet",
  "Aout",
  "Septembre",
  "Octobre",
  "Novembre",
  "Decembre",
];

Map<String, List<Information>> orderByMonth(List<Information> informations) {
  final Map<String, List<Information>> results = {};

  for (var information in informations) {
    final date = DateTime.parse(information.date);
    final key = "${months[date.month - 1]} ${date.year}";
    if (results.containsKey(key)) {
      results[key]?.add(information);
    } else {
      results[key] = [information];
    }
  }

  return results;
}

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => InformationsBloc()..add(InformationInit()),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informations",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(109, 53, 172, 1)),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<InformationsBloc, InformationState>(
                    builder: (context, state) {
                      if (state.status == InformationStatus.loading) {
                        return Center(
                          child: const CircularProgressIndicator(
                            color: Color.fromRGBO(109, 53, 172, 1),
                            strokeWidth: 3,
                          ),
                        );
                      }

                      final List<Widget> globalsWidgets = [];

                      if (state.informations != null) {
                        final ordered = orderByMonth(state.informations!);

                        for (var element in ordered.entries) {
                          final List<Widget> widgets = [];

                          widgets.add(Text(
                            element.key,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(109, 53, 172, 1)),
                          ));

                          widgets.add(const SizedBox(height: 20));

                          for (var information in element.value) {
                            final date = DateTime.parse(information.date);
                            widgets.add(
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(50, 50, 50, 0.1),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    information.title,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color.fromRGBO(
                                                            109, 53, 172, 1)),
                                                  ),
                                                  Text(
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(date),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            247, 159, 2, 1)),
                                                  ),
                                                ]),
                                            Text(
                                              information.description,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      141, 143, 142, 1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                            widgets.add(const SizedBox(height: 10));
                          }

                          widgets.add(const SizedBox(height: 40));

                          globalsWidgets.add(Flex(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              direction: Axis.vertical,
                              children: widgets));
                        }
                      }

                      return Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        // spacing: 10,
                        children: globalsWidgets,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
