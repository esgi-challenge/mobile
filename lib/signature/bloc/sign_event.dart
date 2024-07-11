import 'package:flutter/material.dart';

@immutable
abstract class SignEvent {}

class SignInit extends SignEvent {}

class Sign extends SignEvent {
  final String code;

  Sign(
    this.code,
  );
}
