import 'package:flutter/material.dart';
import 'document_card.dart';

class AdministratifsScreen extends StatelessWidget {
  const AdministratifsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DocumentCard(
          title: "Web Day",
          date: "15 Avril 2024",
        ),
        SizedBox(height: 8),
        DocumentCard(
          title: "Choix électifs",
          date: "15 Avril 2024",
        ),
        SizedBox(height: 8),
        DocumentCard(
          title: "Calendrier synoptique",
          date: "15 Avril 2024",
        ),
      ],
    );
  }
}
