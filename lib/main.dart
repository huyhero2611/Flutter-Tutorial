import 'package:flutter/material.dart';
import './MyApp.dart';

void main() {
  runApp(MaterialApp(
    title: "Transaction app",
    home: MyApp(),
    theme: ThemeData(
      primaryColor: Colors.blue,
    ),
  ));
}
