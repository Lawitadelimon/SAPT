import 'package:flutter/material.dart';

class WelcomeStyles {
  static const Color backgroundColor = Colors.blueAccent;

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle descriptionTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white70,
  );

  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.blueAccent,
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // Estilos para encabezados de tabla y celdas
  static const TextStyle tableHeaderTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 20, 3, 3),
  );

  static const TextStyle tableCellTextStyle = TextStyle(
    color: Colors.black87,
  );
}
