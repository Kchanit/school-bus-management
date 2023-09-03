import 'package:flutter/material.dart';
import 'package:school_bus/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Butt',
      home: RegisterScreen(),
    );
  }
}
