import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key, required this.id});
  final int id;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            ScheduleBloc(CalendarService())..add(LoadSchedule(widget.id)),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is! ScheduleLoaded) {
                  return Center(
                    child: const CircularProgressIndicator(
                      color: Color.fromRGBO(109, 53, 172, 1),
                      strokeWidth: 3,
                    ),
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
                              state.schedule.campus.name,
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
                      height: 180,
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
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(state.schedule.campus.lat,
                                    state.schedule.campus.lon),
                                zoom: 11.0),
                            markers: {
                              Marker(
                                  markerId:
                                      MarkerId(state.schedule.campus.name),
                                  position: LatLng(state.schedule.campus.lat,
                                      state.schedule.campus.lon))
                            },
                          )),
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
                                const CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    "https://i.pravatar.cc/360",
                                  ),
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
                              "Signature",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(109, 53, 172, 1)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                HeroIcon(
                                  HeroIcons.handRaised,
                                  color: !state.signature
                                      ? Colors.red
                                      : Colors.green,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  !state.signature
                                      ? "Vous n'avez pas signé"
                                      : "Vous avez déjà signé",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: !state.signature
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (!state.signature &&
                            state.schedule.date.compareTo(now) > 0)
                          GoRouter.of(context)
                              .push('/calendar/${widget.id}/sign')
                              .then((value) => {
                                    context
                                        .read<ScheduleBloc>()
                                        .add(LoadSchedule(widget.id)),
                                  })
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: !state.signature &&
                                  state.schedule.date.compareTo(now) > 0
                              ? const Color.fromRGBO(249, 178, 53, 1)
                              : const Color.fromRGBO(249, 178, 53, 0.4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(249, 178, 53, 0.1),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
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
