import 'package:flutter/material.dart';
// import 'package:sapt/screens/home_screen.dart';
import 'package:sapt/screens/listTandas_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListTandasScreen(),
    );
  }
}
