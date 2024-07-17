import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile/alert/alert.dart';
import 'package:mobile/calendar/bloc/calendar_bloc.dart';
import 'package:mobile/calendar/bloc/calendar_event.dart';
import 'package:mobile/calendar/bloc/calendar_state.dart';
import 'package:mobile/core/models/schedule.dart';
import 'package:mobile/core/services/calendar_service.dart';

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

Map<int, List<Schedule>> getForMonth(int month, List<Schedule> schedules) {
  final List<Schedule> filteredSchedules = [];

  for (var element in schedules) {
    if (element.date.month == month) {
      filteredSchedules.add(element);
    }
  }

  final Map<int, List<Schedule>> results = {};

  for (var element in filteredSchedules) {
    if (results.containsKey(element.date.day)) {
      results[element.date.day]?.add(element);
    } else {
      results[element.date.day] = [element];
    }
  }

  return results;
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            CalendarBloc(CalendarService())..add(LoadCalendar()),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 40,
              children: [
                const Center(
                  child: Text(
                    "Bonjour 👋",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(109, 53, 172, 1)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${months[now.month - 1]} ${now.year}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(109, 53, 172, 1)),
                    ),
                    // Wrap(
                    //   spacing: 8,
                    //   children: [
                    //     Container(
                    //         width: 32,
                    //         height: 32,
                    //         child: HeroIcon(
                    //           HeroIcons.arrowLeft,
                    //           color: Color.fromRGBO(247, 159, 2, 1),
                    //         )),
                    //     Container(
                    //         width: 32,
                    //         height: 32,
                    //         child: HeroIcon(
                    //           HeroIcons.arrowRight,
                    //           color: Color.fromRGBO(247, 159, 2, 1),
                    //         ))
                    //   ],
                    // ),
                  ],
                ),
                Flex(
                  direction: Axis.vertical,
                  children: [
                    BlocBuilder<CalendarBloc, CalendarState>(
                        builder: (context, state) {
                      if (state is CalendarLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(109, 53, 172, 1),
                            strokeWidth: 3,
                          ),
                        );
                      }

                      if (state is CalendarError) {
                        return Alert(
                          errorMsg: state.errorMessage,
                        );
                      }

                      if (state is! CalendarLoaded) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(109, 53, 172, 1),
                            strokeWidth: 3,
                          ),
                        );
                      }

                      final orderedByDays =
                          getForMonth(now.month, state.schedules);

                      final List<Widget> dayLists = [];

                      var keys = orderedByDays.keys.toList()..sort();

                      keys.forEach((key) {
                        final element = orderedByDays[key]!;
                        final List<Widget> widgets = [];

                        element.forEach((schedule) {
                          final endDate = schedule.date
                              .add(Duration(minutes: schedule.duration));
                          widgets.add(GestureDetector(
                            onTap: () => {
                              GoRouter.of(context)
                                  .push('/calendar/${schedule.id}')
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: now.compareTo(endDate) < 0
                                    ? const Color.fromRGBO(72, 2, 151, 1)
                                    : const Color.fromRGBO(72, 2, 151, 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              width: 178,
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          DateFormat.Hm().format(schedule.date),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          DateFormat.Hm().format(
                                            schedule.date.add(
                                              Duration(
                                                  minutes: schedule.duration),
                                            ),
                                          ),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schedule.course,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          schedule.campus.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                        });

                        dayLists.add(Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(50, 50, 50, 0.1),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${key}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 64,
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromRGBO(109, 53, 172, 1)),
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: 6,
                                  children: widgets,
                                )
                              ],
                            ),
                          ),
                        ));
                        dayLists.add(
                          const SizedBox(height: 16),
                        );
                      });

                      // state.schedules.forEach((schedule) {
                      //   widgets.add(Container(
                      //     decoration: BoxDecoration(
                      //       color: now.compareTo(schedule.date) < 0
                      //           ? Color.fromRGBO(72, 2, 151, 1)
                      //           : Color.fromRGBO(72, 2, 151, 0.5),
                      //       borderRadius: BorderRadius.all(Radius.circular(4)),
                      //     ),
                      //     width: 178,
                      //     child: Padding(
                      //       padding: EdgeInsets.all(4.0),
                      //       child: Row(
                      //         children: [
                      //           Column(
                      //             children: [
                      //               Text(
                      //                 DateFormat.Hm().format(schedule.date),
                      //                 style: TextStyle(color: Colors.white),
                      //               ),
                      //               SizedBox(height: 4),
                      //               Text(
                      //                 DateFormat.Hm().format(
                      //                   schedule.date.add(
                      //                     Duration(minutes: schedule.duration),
                      //                   ),
                      //                 ),
                      //                 style: TextStyle(color: Colors.white),
                      //               ),
                      //             ],
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ));
                      // });

                      return Flex(
                        direction: Axis.vertical,
                        children: dayLists,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
