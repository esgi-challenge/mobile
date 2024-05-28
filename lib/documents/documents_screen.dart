import 'package:flutter/material.dart';
import 'package:mobile/documents/administratifs_screen.dart';
import 'package:mobile/documents/cours_screen.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 242, 249, 1),
          body: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Documents",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(109, 53, 172, 1),
                  ),
                ),
                SizedBox(height: 40),
                TabBar(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(247, 159, 2, 1),
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  indicatorColor: Color.fromRGBO(247, 159, 2, 1),
                  tabs: [
                    Tab(text: "Administratifs"),
                    Tab(text: "Cours"),
                  ],
                ),
                SizedBox(height: 32),
                Expanded(
                  child: TabBarView(
                    children: [
                      AdministratifsScreen(),
                      CoursScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
