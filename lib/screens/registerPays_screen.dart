import 'package:flutter/material.dart';
import 'package:sapt/themes/welcome_styles.dart';

class RegisterPaysScreen extends StatefulWidget {
  @override
  _RegisterPaysScreenState createState() => _RegisterPaysScreenState();
}

class _RegisterPaysScreenState extends State<RegisterPaysScreen> {
  // Lista de registros donde cada registro es un Map que contiene Nombre, Pago y Fecha
  List<Map<String, String>> registros = [];

  // Método para mostrar un cuadro de diálogo y agregar un registro
  void _agregarRegistro() {
    TextEditingController nombreController = TextEditingController();
    TextEditingController pagoController = TextEditingController();
    TextEditingController fechaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Agregar Nuevo Registro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: pagoController,
                decoration: InputDecoration(labelText: "Pago"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: fechaController,
                decoration: InputDecoration(labelText: "Fecha"),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  registros.add({
                    'Nombre': nombreController.text,
                    'Pago': pagoController.text,
                    'Fecha': fechaController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              style: WelcomeStyles.buttonStyle,
              child: Text("Agregar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Pagos"),
        backgroundColor: WelcomeStyles.backgroundColor,
      ),
      body: Stack(children: [
        ListView(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Nombre",
                          style: WelcomeStyles.tableHeaderTextStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Pago",
                          style: WelcomeStyles.tableHeaderTextStyle,
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Fecha",
                          style: WelcomeStyles.tableHeaderTextStyle,
                        ),
                      ),
                    ],
                    rows: registros.map((registro) {
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            registro['Nombre'] ?? '',
                            style: WelcomeStyles.tableCellTextStyle,
                          )),
                          DataCell(Text(
                            registro['Pago'] ?? '',
                            style: WelcomeStyles.tableCellTextStyle,
                          )),
                          DataCell(Text(
                            registro['Fecha'] ?? '',
                            style: WelcomeStyles.tableCellTextStyle,
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: _agregarRegistro,
                child: const Row(
                  children: [Icon(Icons.add), Text("Nuevo pago")],
                )))
      ]),
    );
  }
}
