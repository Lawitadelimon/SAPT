import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapt/Screens/welcome_screen.dart';
import 'package:sapt/firebase_options.dart';
<<<<<<< HEAD
import 'package:sapt/screens/login_screen.dart';
=======
import 'package:sapt/services/tanda_manager.dart';
>>>>>>> 1471c49bd1e0f11f275d4c95ab16792564d1afc8

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => TandaManager(),
      child: const MainApp(),
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
      home: LoginScreen(),
    );
  }
}
