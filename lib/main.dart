import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/app.dart';

void main() async {
  await dotenv.load(fileName: "dotenv");
  runApp(const App());
}
