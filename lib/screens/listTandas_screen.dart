import 'package:flutter/material.dart';
import 'package:sapt/screens/createTanda_screen.dart';
import 'package:sapt/screens/home_screen.dart';

class ListTandasScreen extends StatefulWidget {
  const ListTandasScreen({super.key});

  @override
  State<ListTandasScreen> createState() => _ListTandasScreenState();
}

class _ListTandasScreenState extends State<ListTandasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Text("Hola"),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white),
        title: const Text("Lista de tandas"),
        actions: [TextButton(onPressed: () {}, child: const Text("Código"))],
      ),
      body: Stack(children: [
        ListView(children: [
          ListTile(
            leading: const IconTheme(
                data: IconThemeData(color: Colors.blue),
                child: Icon(Icons.payments)),
            title: const Text("Tanda 01"),
            subtitle: const Text("Creada: 15 - Nov - 2024"),
            onTap: () {
              final rutaDataScreen = MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              });
              Navigator.push(context, rutaDataScreen);
            },
          ),
          const ListTile(
            leading: IconTheme(
                data: IconThemeData(color: Colors.blue),
                child: Icon(Icons.payments)),
            title: Text("Tanda 02"),
            subtitle: Text("Creada: 17 - Nov - 2024"),
          ),
        ]),
        Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: () {
                  final rutaDataScreen = MaterialPageRoute(builder: (context) {
                    return const CreateTandaScreen();
                  });
                  Navigator.push(context, rutaDataScreen);
                },
                child: const Row(
                  children: [Icon(Icons.add), Text("Nueva")],
                )))
      ]),
    );
  }
}
