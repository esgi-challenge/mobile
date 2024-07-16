import 'package:flutter/material.dart';
import 'package:mobile/core/models/document.dart';

@immutable
abstract class DocumentState {}

class DocumentInitial extends DocumentState {}

class DocumentLoading extends DocumentState {}

class DocumentLoaded extends DocumentState {
  final List<Document> documents;

  DocumentLoaded({
    required this.documents,
  });
}

class DocumentError extends DocumentState {
  final String errorMessage;

  DocumentError({required this.errorMessage});
}
