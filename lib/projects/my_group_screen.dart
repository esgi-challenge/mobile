import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MyGroupScreen extends StatelessWidget {
  const MyGroupScreen({super.key});

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
                    "Mon groupe",
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
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TP noté",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Intégration - tailwindcss & sass",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.calendarDays,
                            color: Color.fromRGBO(247, 159, 2, 1),
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "15 Avril 2024",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                          ),
                          SizedBox(width: 32),
                          HeroIcon(
                            HeroIcons.clock,
                            color: Color.fromRGBO(247, 159, 2, 1),
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "23h00",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(247, 159, 2, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
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
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Intervenant",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.userCircle,
                            color: Color.fromRGBO(109, 53, 172, 1),
                            size: 32,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "M. SOMBIE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(109, 53, 172, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
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
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Membres",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(72, 2, 151, 1),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.userCircle,
                            color: Color.fromRGBO(109, 53, 172, 1),
                            size: 32,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "John DOE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(109, 53, 172, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.userCircle,
                            color: Color.fromRGBO(109, 53, 172, 1),
                            size: 32,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "John DOE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(109, 53, 172, 1),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          HeroIcon(
                            HeroIcons.userCircle,
                            color: Color.fromRGBO(109, 53, 172, 1),
                            size: 32,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "John DOE",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(109, 53, 172, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(249, 178, 53, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(249, 178, 53, 0.1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeroIcon(
                        HeroIcons.userCircle,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Voir le sujet",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
