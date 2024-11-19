import 'package:flutter/material.dart';
import 'package:sapt/screens/listTandas_screen.dart';
import 'package:sapt/themes/welcome_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WelcomeStyles.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¡Bienvenido!",
                style: WelcomeStyles.titleTextStyle,
              ),
              const SizedBox(height: 20),
              const Text(
                "Explora la app y descubre todo lo que tenemos para ti.",
                textAlign: TextAlign.center,
                style: WelcomeStyles.descriptionTextStyle,
              ),
              const Text(
                "La mejor app de pago piramidal.",
                textAlign: TextAlign.center,
                style: WelcomeStyles.descriptionTextStyle,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListTandasScreen()),
                  );
                },
                style: WelcomeStyles.buttonStyle,
                child: const Text(
                  "Comenzar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
