import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';

import 'package:mobile/core/services/calendar_service.dart';
import 'package:mobile/schedule/bloc/calendar_bloc.dart';
import 'package:mobile/schedule/bloc/calendar_event.dart';
import 'package:mobile/schedule/bloc/calendar_state.dart';

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

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            ScheduleBloc(CalendarService())..add(LoadSchedule(id)),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is! ScheduleLoaded) {
                  return const CircularProgressIndicator(
                    color: Color.fromRGBO(109, 53, 172, 1),
                    strokeWidth: 3,
                  );
                }

                return Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 12,
                  children: [
                    const Center(
                      child: Text(
                        "Cours",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(109, 53, 172, 1)),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.schedule.course,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(109, 53, 172, 1)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const HeroIcon(
                                  HeroIcons.calendarDays,
                                  color: Color.fromRGBO(247, 159, 2, 1),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${state.schedule.date.day} ${months[state.schedule.date.month - 1]} ${state.schedule.date.year}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(247, 159, 2, 1),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const HeroIcon(
                                  HeroIcons.clock,
                                  color: Color.fromRGBO(247, 159, 2, 1),
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  DateFormat.Hm().format(state.schedule.date),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(247, 159, 2, 1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.schedule.campus,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(109, 53, 172, 1)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Intervenant",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(109, 53, 172, 1)),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "M. ${state.schedule.teacher}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
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
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Text(
                          "Signer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
