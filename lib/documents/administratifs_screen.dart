import 'package:flutter/material.dart';
import 'package:mobile/core/models/document.dart';
import 'document_card.dart';

class AdministratifsScreen extends StatelessWidget {
  final List<Document> documents;
  const AdministratifsScreen({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    for (var document in documents) {
      widgets.add(
        DocumentCard(
          title: document.name,
          date: document.date,
        ),
      );
      widgets.add(const SizedBox(height: 8));
    }

    return Column(
      children: widgets,
    );
  }
}
