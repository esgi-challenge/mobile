import 'package:flutter/material.dart';

class AttendancesScreen extends StatelessWidget {
  const AttendancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 242, 249, 1),
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mes absences",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(109, 53, 172, 1),
                ),
              ),
              SizedBox(height: 32),
              AbsenceCard(
                title: "Flutter",
                date: "15 Avril 2024",
                time: "8h00 - 9h30",
                status: "Justifiée",
                statusColor: Color.fromRGBO(137, 223, 144, 1),
                onTap: () => _showBottomSheet(context),
              ),
              SizedBox(height: 8),
              AbsenceCard(
                title: "Tailwind CSS",
                date: "12 Avril 2024",
                time: "9h45 - 11h15",
                status: "En attente",
                statusColor: Color.fromRGBO(248, 195, 101, 1),
                onTap: () => _showBottomSheet(context),
              ),
              SizedBox(height: 8),
              AbsenceCard(
                title: "Sécurité",
                date: "11 Avril 2024",
                time: "14h00 - 15h30",
                status: "Injustifiée",
                statusColor: Color.fromRGBO(238, 102, 102, 1),
                onTap: () => _showBottomSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AbsenceCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  const AbsenceCard({
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(72, 2, 151, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: Color.fromRGBO(247, 159, 2, 1)),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Color.fromRGBO(247, 159, 2, 1)),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
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
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Régulariser",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(72, 2, 151, 1),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Saisissez la raison de votre absence et un justificatif.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 242, 249, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Bonjour, j’étais absent hier. Ci-joint l’arrêt donné par mon médecin.",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(109, 53, 172, 1),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(247, 159, 2, 1),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Envoyer",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}