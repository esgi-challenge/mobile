import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/projects/groups_screen.dart';
import 'package:mobile/projects/my_group_screen.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  ProjectCard(
                    title: "Challenge Stack",
                    course: "Flutter Golang DevOps",
                    dueDate: "15 Avril 2024",
                    dueTime: "23:59",
                  ),
                  const SizedBox(height: 8),
                  ProjectCard(
                    title: "Partiel",
                    course: "Sécurité",
                    dueDate: "15 Avril 2024",
                    dueTime: "23:59",
                  ),
                  const SizedBox(height: 8),
                  ProjectCard(
                    title: "TP noté",
                    course: "Golang",
                    dueDate: "15 Avril 2024",
                    dueTime: "23:59",
                  ),
                ],
              )
            ],
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

  const ProjectCard({
    required this.title,
    required this.course,
    required this.dueDate,
    required this.dueTime,
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
                        Container(
                            width: 16,
                            height: 16,
                            child: HeroIcon(
                              HeroIcons.calendarDays,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            )
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dueDate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(247, 159, 2, 1),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Container(
                            width: 16,
                            height: 16,
                            child: HeroIcon(
                              HeroIcons.clock,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            )
                        ),
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
                  _showBottomSheet(context);
                },
                child: Container(
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

void _showBottomSheet(BuildContext context) {
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
                  MaterialPageRoute(builder: (context) => MyGroupScreen()),
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
