import 'package:flutter/material.dart';
import 'package:diary/login.dart/interface.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';
    return MaterialApp(
      title: "回响树洞",
      home: Scaffold(
        body: Interface(),
      ),
    );
  }
}