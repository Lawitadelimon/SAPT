import 'package:flutter/material.dart';
import 'package:sapt/screens/registerPays_screen.dart';
import 'package:sapt/services/tanda_manager.dart';
import 'package:sapt/screens/listaPagosScreen.dart';

class HomeScreen extends StatefulWidget {
  final Tanda tanda;
  const HomeScreen({super.key, required this.tanda});

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
          title: Text(widget.tanda.nombre),
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
                        _showIntegrantes();
                      },
                      label: const Text("Integrantes"),
                      icon: const Icon(Icons.person),
                      style: TextButton.styleFrom(
                          iconColor: Colors.white,
                          foregroundColor: Colors.white)),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPaysScreen()),
                        );
                      },
                      label: const Text("Pagos"),
                      icon: const Icon(Icons.payment),
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
              child: Text("Fecha de hoy: 20 - Nov - 2024"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
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
                      Text("${widget.tanda.turno}"),
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

  void _showIntegrantes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Integrantes de la tanda"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [integrantes()],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  integrantes() {
    if (widget.tanda.participantes.isNotEmpty) {
      for (String inte in widget.tanda.participantes) {
        return Text(inte);
      }
    } else {
      return const Text("No existen integrantes");
    }
  }
}
