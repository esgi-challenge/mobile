import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/alert/alert.dart';
import 'package:mobile/core/services/document_service.dart';
import 'package:mobile/documents/administratifs_screen.dart';
import 'package:mobile/documents/bloc/document_bloc.dart';
import 'package:mobile/documents/bloc/document_event.dart';
import 'package:mobile/documents/bloc/document_state.dart';
import 'package:mobile/documents/cours_screen.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            DocumentBloc(DocumentService())..add(LoadDocuments()),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(245, 242, 249, 1),
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Documents",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(109, 53, 172, 1),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<DocumentBloc, DocumentState>(
                    builder: (context, state) {
                      if (state is DocumentLoading ||
                          state is DocumentInitial) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(109, 53, 172, 1),
                            strokeWidth: 3,
                          ),
                        );
                      }

                      if (state is DocumentError) {
                        return const Alert();
                      }

                      if (state is DocumentLoaded) {
                        final adminDocuments = state.documents
                            .where((d) => d.administrative)
                            .toList();
                        final courseDocuments = state.documents
                            .where((d) => !d.administrative)
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TabBar(
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
                            const SizedBox(height: 32),
                            Container(
                              height: 280,
                              child: TabBarView(
                                children: [
                                  AdministratifsScreen(
                                    documents: adminDocuments,
                                  ),
                                  CoursScreen(
                                    documents: courseDocuments,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
