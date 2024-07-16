import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/core/models/document.dart';
import 'document_card.dart';

class CoursScreen extends StatelessWidget {
  final List<Document> documents;
  const CoursScreen({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    for (var document in documents) {
      widgets.add(
        DocumentCard(
          title: document.name,
          date: document.date,
          path: document.path,
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(width: 1, color: Color.fromRGBO(72, 2, 151, 1)),
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
        Column(
          children: widgets,
        ),
      ],
    );
  }
}
