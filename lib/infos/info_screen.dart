import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/infos/blocs/informations_bloc.dart';
import 'package:mobile/infos/blocs/informations_event.dart';
import 'package:mobile/infos/blocs/informations_state.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => InformationsBloc()..add(InformationInit()),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 242, 249, 1),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32.0),
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
                  SizedBox(height: 40),
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // spacing: 10,
                    children: [
                      const Text(
                        "Avril 2024",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(109, 53, 172, 1)),
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<InformationsBloc, InformationState>(
                        builder: (context, state) {
                          final List<Widget> widgets = [];

                          state.informations?.forEach(
                            (information) {
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
                                        Container(
                                          height: 52,
                                          width: 52,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 10),
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
                              widgets.add(SizedBox(height: 10));
                            },
                          );

                          return Flex(
                              direction: Axis.vertical, children: widgets
                              // [
                              //   Container(
                              //     decoration: const BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(8)),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Color.fromRGBO(50, 50, 50, 0.1),
                              //           spreadRadius: 0,
                              //           blurRadius: 5,
                              //           offset: Offset(
                              //               0, 3), // changes position of shadow
                              //         ),
                              //       ],
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Row(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Container(
                              //             height: 52,
                              //             width: 52,
                              //             color: Colors.red,
                              //           ),
                              //           const SizedBox(width: 10),
                              //           const Expanded(
                              //             child: Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Row(
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment
                              //                             .spaceBetween,
                              //                     children: [
                              //                       Text(
                              //                         "Mme. DUPONT",
                              //                         textAlign: TextAlign.left,
                              //                         style: TextStyle(
                              //                             fontSize: 14,
                              //                             fontWeight:
                              //                                 FontWeight.w700,
                              //                             color: Color.fromRGBO(
                              //                                 109, 53, 172, 1)),
                              //                       ),
                              //                       Text(
                              //                         "22/04/2024",
                              //                         textAlign: TextAlign.left,
                              //                         style: TextStyle(
                              //                             fontSize: 14,
                              //                             fontWeight:
                              //                                 FontWeight.w400,
                              //                             color: Color.fromRGBO(
                              //                                 247, 159, 2, 1)),
                              //                       ),
                              //                     ]),
                              //                 Text(
                              //                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
                              //                   textAlign: TextAlign.left,
                              //                   style: TextStyle(
                              //                       fontSize: 14,
                              //                       color: Color.fromRGBO(
                              //                           141, 143, 142, 1)),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              //   SizedBox(height: 10),
                              // ],
                              );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // spacing: 10,
                    children: [
                      const Text(
                        "Mars 2024",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(109, 53, 172, 1)),
                      ),
                      SizedBox(height: 20),
                      Flex(
                        direction: Axis.vertical,
                        children: [
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 52,
                                    width: 52,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mme. DUPONT",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  109, 53, 172, 1)),
                                        ),
                                        Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
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
                          SizedBox(height: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 52,
                                    width: 52,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mme. DUPONT",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  109, 53, 172, 1)),
                                        ),
                                        Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
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
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
