import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/collapsible/collapsible.dart';

class MoreCoursesScreen extends StatelessWidget {
  const MoreCoursesScreen({super.key});

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
                "Matières",
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
                  Collapsible(
                    title: "DevOps",
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
                            const Text(
                              "Raphaël KIFFER",
                              textAlign: TextAlign.left,
                              style: TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const Column(
                              children: [
                                Text(
                                  "CC1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "CC2",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "Partiel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Collapsible(
                    title: "DevOps",
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
                            const Text(
                              "Raphaël KIFFER",
                              textAlign: TextAlign.left,
                              style: TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const Column(
                              children: [
                                Text(
                                  "CC1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "CC2",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                            const Column(
                              children: [
                                Text(
                                  "Partiel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(109, 53, 172, 1),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "18",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(145, 103, 193, 1),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 64,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Moyenne: 14.66",
                              textAlign: TextAlign.end,
                              style: TextStyle(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
