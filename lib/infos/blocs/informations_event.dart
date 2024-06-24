import 'package:flutter/material.dart';

@immutable
sealed class InformationEvent {}

final class InformationInit extends InformationEvent {}
