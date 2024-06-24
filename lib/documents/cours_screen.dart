import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'document_card.dart';

class CoursScreen extends StatelessWidget {
  const CoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        DocumentCard(
          title: "Support de cours",
          date: "15 Avril 2024",
        ),
        SizedBox(height: 8),
        DocumentCard(
          title: "Sujet TP",
          date: "15 Avril 2024",
        ),
        SizedBox(height: 8),
        DocumentCard(
          title: "Exercices",
          date: "15 Avril 2024",
        ),
      ],
    );
  }
}
