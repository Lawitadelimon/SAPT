import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapt/Screens/welcome_screen.dart';
import 'package:sapt/screens/listaPagosScreen.dart';
import 'package:sapt/screens/pagosModel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PagosModel(),
      child: const MaterialApp(home: ListaPagosScreen()),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
