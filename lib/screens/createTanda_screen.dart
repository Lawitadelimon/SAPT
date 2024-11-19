import 'package:flutter/material.dart';

class CreateTandaScreen extends StatefulWidget {
  const CreateTandaScreen({super.key});

  @override
  State<CreateTandaScreen> createState() => _CreateTandaScreenState();
}

class _CreateTandaScreenState extends State<CreateTandaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear tanda")),
      body: ListView(
        children: [
          SizedBox(height: 50, child: entradaNombre()),
          SizedBox(height: 50, child: entradaIntegrantes()),
          SizedBox(height: 50, child: entradaMonto()),
          SizedBox(height: 50, child: entradaCodigo()),
          ElevatedButton(onPressed: () {}, child: const Text("Crear tanda"))
        ],
      ),
    );
  }

  TextField entradaNombre() {
    return const TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Dale un nombre a tu tanda',
      ),
    );
  }

  TextField entradaIntegrantes() {
    return const TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Número de integrantes',
      ),
    );
  }

  TextField entradaMonto() {
    return const TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Monto por cada integrante',
      ),
    );
  }

  TextField entradaCodigo() {
    return const TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Crea un código para esta tanda',
      ),
    );
  }
}
