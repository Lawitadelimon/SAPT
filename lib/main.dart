import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sapt/firebase_options.dart';
// import 'package:sapt/screens/home_screen.dart';
import 'package:sapt/screens/listTandas_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
