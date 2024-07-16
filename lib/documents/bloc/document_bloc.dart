import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/services/document_service.dart';
import 'package:mobile/documents/bloc/document_event.dart';
import 'package:mobile/documents/bloc/document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentService documentService;

  DocumentBloc(this.documentService) : super(DocumentInitial()) {
    on<LoadDocuments>((event, emit) async {
      emit(DocumentLoading());
      try {
        final documents = await documentService.getDocuments();
        emit(DocumentLoaded(documents: documents));
      } on Exception catch (e) {
        emit(DocumentError(errorMessage: e.toString()));
      }
    });
  }
}
