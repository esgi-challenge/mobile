import 'package:flutter/material.dart';

@immutable
sealed class AuthEvent {}

final class AuthInit extends AuthEvent {}

final class AuthLogged extends AuthEvent {
  final String jwt;

  AuthLogged({required this.jwt});
}
