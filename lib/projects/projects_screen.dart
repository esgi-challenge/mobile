import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/alert/alert.dart';
import 'package:mobile/core/models/project.dart';
import 'package:mobile/core/services/projects_service.dart';
import 'package:mobile/projects/bloc/projects_bloc.dart';
import 'package:mobile/projects/bloc/projects_event.dart';
import 'package:mobile/projects/bloc/projects_state.dart';
import 'package:mobile/projects/groups_screen.dart';
import 'package:mobile/projects/my_group_screen.dart';

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

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            ProjectsBloc(ProjectsService())..add(ProjectsInit()),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Projets",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(109, 53, 172, 1),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: Color.fromRGBO(72, 2, 151, 1)),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2024",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(72, 2, 151, 1)),
                          ),
                          HeroIcon(
                            HeroIcons.chevronDown,
                            color: Color.fromRGBO(72, 2, 151, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<ProjectsBloc, ProjectsState>(
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

                        if (state is ProjectsLoaded) {
                          final List<Widget> widgets = [];

                          for (var project in state.projects) {
                            widgets.add(
                              ProjectCard(
                                project: project,
                                title: project.title,
                                course: project.course,
                                dueDate:
                                    "${project.endDate.day} ${months[project.endDate.month - 1]} ${project.endDate.year}",
                                dueTime: "23:59",
                              ),
                            );
                          }

                          return Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 8,
                            children: widgets,
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String course;
  final String dueDate;
  final String dueTime;
  final Project project;

  const ProjectCard({
    super.key,
    required this.title,
    required this.course,
    required this.dueDate,
    required this.dueTime,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(72, 2, 151, 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      course,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(72, 2, 151, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(
                            width: 16,
                            height: 16,
                            child: HeroIcon(
                              HeroIcons.calendarDays,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            )),
                        const SizedBox(width: 4),
                        Text(
                          dueDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(247, 159, 2, 1),
                          ),
                        ),
                        const SizedBox(width: 32),
                        const SizedBox(
                            width: 16,
                            height: 16,
                            child: HeroIcon(
                              HeroIcons.clock,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            )),
                        const SizedBox(width: 4),
                        Text(
                          dueTime,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(247, 159, 2, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context, project);
                },
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: HeroIcon(
                    HeroIcons.ellipsisVertical,
                    color: Color.fromRGBO(247, 159, 2, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, Project project) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: HeroIcon(
                HeroIcons.eye,
                color: Color.fromRGBO(247, 159, 2, 1),
              ),
              title: const Text(
                "Suivi de mon groupe",
                style: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyGroupScreen(
                            project: project,
                          )),
                );
              },
            ),
            ListTile(
              leading: HeroIcon(
                HeroIcons.userGroup,
                color: Color.fromRGBO(247, 159, 2, 1),
              ),
              title: const Text(
                "Voir les groupes",
                style: TextStyle(
                  color: Color.fromRGBO(72, 2, 151, 1),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupsScreen()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
