import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String date;

  const DocumentCard({
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        child: HeroIcon(
                          HeroIcons.calendarDays,
                          color: Color.fromRGBO(247, 159, 2, 1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        date,
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
            Container(
              width: 32,
              height: 32,
              child: HeroIcon(
                HeroIcons.eye,
                color: Color.fromRGBO(247, 159, 2, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
