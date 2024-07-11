import 'package:flutter/material.dart';

@immutable
abstract class SignState {}

class SignInitial extends SignState {}

class SignLoaded extends SignState {}

class SignLoading extends SignState {}

class SignError extends SignState {
  final String errorMessage;

  SignError({required this.errorMessage});
}
