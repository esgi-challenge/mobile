import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/alert/alert.dart';
import 'package:mobile/core/models/project.dart';
import 'package:mobile/core/services/projects_service.dart';
import 'package:mobile/projects/bloc/projects_bloc.dart';
import 'package:mobile/projects/bloc/projects_event.dart';
import 'package:mobile/projects/bloc/projects_state.dart';

class GroupsScreen extends StatelessWidget {
  final Project project;
  const GroupsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const HeroIcon(
                      HeroIcons.arrowLongLeft,
                      color: Color.fromRGBO(247, 159, 2, 1),
                      size: 32,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Groupes",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(109, 53, 172, 1),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 40),
              // Card here
              BlocProvider(
                create: (context) => ProjectsBloc(ProjectsService())
                  ..add(
                    GroupLoad(project.id),
                  ),
                child: BlocBuilder<ProjectsBloc, ProjectsState>(
                  builder: (context, state) {
                    if (state is ProjectsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(109, 53, 172, 1),
                          strokeWidth: 3,
                        ),
                      );
                    }

                    if (state is ProjectsError) {
                      return const Alert();
                    }

                    if (state is GroupLoaded) {
                      final List<Widget> widgets = [];

                      for (var group in state.groups) {
                        final List<Widget> widgetUsers = [];

                        for (var u in group.members) {
                          widgetUsers.add(
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(72, 2, 151, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const HeroIcon(
                                    HeroIcons.userCircle,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        u.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        u.className,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        widgets.add(
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(50, 50, 50, 0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${group.id}",
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(72, 2, 151, 1),
                                        ),
                                      ),
                                      group.joined
                                          ? GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<ProjectsBloc>()
                                                    .add(GroupQuit(project.id));
                                              },
                                              child: const HeroIcon(
                                                HeroIcons.userMinus,
                                                color: Color.fromRGBO(
                                                    247, 159, 2, 1),
                                                size: 32,
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<ProjectsBloc>()
                                                    .add(GroupJoin(
                                                        group.id, project.id));
                                              },
                                              child: const HeroIcon(
                                                HeroIcons.userPlus,
                                                color: Color.fromRGBO(
                                                    247, 159, 2, 1),
                                                size: 32,
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      children: widgetUsers,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        widgets.add(const SizedBox(
                          height: 12,
                        ));
                      }

                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: 12,
                        children: widgets,
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
