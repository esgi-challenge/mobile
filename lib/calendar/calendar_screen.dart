import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  const Text(
                    "Avril 2024",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(109, 53, 172, 1)),
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      Container(
                          width: 32,
                          height: 32,
                          child: HeroIcon(
                            HeroIcons.arrowLeft,
                            color: Color.fromRGBO(247, 159, 2, 1),
                          )),
                      Container(
                          width: 32,
                          height: 32,
                          child: HeroIcon(
                            HeroIcons.arrowRight,
                            color: Color.fromRGBO(247, 159, 2, 1),
                          ))
                    ],
                  ),
                ],
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(50, 50, 50, 0.1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "16",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(109, 53, 172, 1)),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 6,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(72, 2, 151, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 178,
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(72, 2, 151, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                width: 178,
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(72, 2, 151, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                width: 178,
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(50, 50, 50, 0.1),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "17",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(109, 53, 172, 1)),
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 6,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(72, 2, 151, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 178,
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(72, 2, 151, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                width: 178,
                                height: 40,
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    'Hello',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
