import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sapt/screens/pagosModel.dart';

class ListaPagosScreen extends StatelessWidget {
  const ListaPagosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagos Pendientes")),
      body: Consumer<PagosModel>(
        builder: (context, pagosModel, child) {
          return ListView.builder(
            itemCount: pagosModel.pagosPendientes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(pagosModel.pagosPendientes[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    pagosModel.eliminarPago(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PagosModel>(context, listen: false)
              .agregarPago("Pago ${DateTime.now()}");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
