import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sapt/services/tanda_manager.dart';
import 'package:sapt/screens/listaPagosScreen.dart';

class HomeScreen extends StatefulWidget {
  final String tandaId;

  const HomeScreen({super.key, required this.tandaId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tanda = TandaManager.getTandaRef(widget.tandaId);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(color: Colors.white),
          title: Text("Detalles de la tanda"),
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
                              builder: (context) => const ListaPagosScreen()),
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
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: tanda.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Tanda no encontrada'));
          }

          final tandaData = snapshot.data!.data();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${tandaData?['nombre']}',
                    style: TextStyle(fontSize: 18)),
                Text('Administrador: ${tandaData?['admin']}',
                    style: TextStyle(fontSize: 18)),
                Text('Monto semanal: ${tandaData?['monto']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
