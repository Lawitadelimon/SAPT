import 'package:flutter/material.dart';
import 'package:sapt/screens/listaPagosScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(color: Colors.white),
          title: const Text('TANDA 01'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(50.0), // Altura de la barra personalizada
            child: Container(
              color: Colors.blue, // Color de fondo de la barra personalizada
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListaPagosScreen()),
                        );
                      },
                      label: const Text("Pagos"),
                      icon: const Icon(Icons.payment),
                      style: TextButton.styleFrom(
                          iconColor: Colors.white,
                          foregroundColor: Colors.white)),
                  TextButton.icon(
                      onPressed: () {},
                      label: const Text("Tandas"),
                      icon: const Icon(Icons.person),
                      style: TextButton.styleFrom(
                          iconColor: Colors.white,
                          foregroundColor: Colors.white)),
                  TextButton.icon(
                      onPressed: () {},
                      label: const Text("Pendientes"),
                      icon: const Icon(Icons.list),
                      style: TextButton.styleFrom(
                          iconColor: Colors.white,
                          foregroundColor: Colors.white)),
                ],
              ),
            ),
          )),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25.0, bottom: 50.0),
            child: const Center(
              child: Text("Fecha de hoy: 15 - Nov - 2024"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: const Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      strokeWidth: 20,
                      color: Colors.blue,
                      value: 0.7,
                    ),
                  ),
                  Column(
                    children: [
                      Text("No. 3"),
                      Text("Marina Portillo"),
                      Text("20 - Nov - 2024"),
                      Text("70%")
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "DAR TANDA",
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
