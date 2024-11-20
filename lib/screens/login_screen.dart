import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          children: const [

          const SizedBox(height: 50),

          const Icon(
          Icons.lock,
          size: 100,
          ),

          const SizedBox(height: 50),

          Text('Bienvenido',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            ),
          ),

          const SizedBox(height: 25),

          Padding(
            padding: EdgeInsets.symmetric(horizontal:25.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide( color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.grey,
                  filled: true,
              ),
            ),
          ),


        ],),
      ),
    );
  }
}