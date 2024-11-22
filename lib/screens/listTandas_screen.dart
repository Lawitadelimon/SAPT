import 'package:flutter/material.dart';
import 'package:sapt/screens/home_screen.dart';
import 'package:sapt/services/tanda_manager.dart';
import 'package:sapt/themes/apptheme.dart';
import 'package:sapt/themes/welcome_styles.dart';

class ListTandasScreen extends StatefulWidget {
  const ListTandasScreen({super.key});

  @override
  State<ListTandasScreen> createState() => _ListTandasScreenState();
}

class _ListTandasScreenState extends State<ListTandasScreen> {
  List<Tanda> _tandas = [];

  @override
  void initState() {
    super.initState();
    // Registrar el listener al iniciar la pantalla
    TandaManager.instance.agregarListener(_actualizarTandas);
    // Comenzar a observar tandas
    TandaManager.instance.observarTandas();
    try {
      // Aquí llamas a tu lógica para obtener tandas
      TandaManager.instance.obtenerTandas();
      print("Stream de tandas inicializado correctamente.");
    } catch (e, stackTrace) {
      print("Error al inicializar el stream de tandas: $e");
      print("Stack trace: $stackTrace");
    }
  }

  @override
  void dispose() {
    // Remover el listener al salir de la pantalla
    TandaManager.instance.removerListener(_actualizarTandas);

    // Liberar el controlador cuando el widget se destruye
    _textControllerName.dispose();
    _textControllerInt.dispose();
    _textControllerMonto.dispose();
    _textControllerCodigo.dispose();
    super.dispose();
  }

  // Método para actualizar la lista de tandas
  void _actualizarTandas(List<Tanda> tandas) {
    try {
      setState(() {
        _tandas = tandas;
        // print("Tandas actualizadas: ${_tandas.length}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('¡Ha ocurrido una actualización en las tandas!')),
        );
      });
    } catch (e, stackTrace) {
      print("Error al actualizar las tandas: $e");
      print("Stack trace: $stackTrace");
    }
  }

  TextEditingController _textControllerName = TextEditingController();
  TextEditingController _textControllerInt = TextEditingController();
  TextEditingController _textControllerMonto = TextEditingController();
  TextEditingController _textControllerCodigo = TextEditingController();

  void _unirseTanda() {
    TextEditingController codigoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Unirme a una tanda"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codigoController,
                decoration: const InputDecoration(labelText: "Código"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (await TandaManager.instance
                    .unirseATanda(codigoController.text, "Javier Lopez Co")) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Te has unido a la tanda!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Ha ocurrido un error. Intenta de nuevo más tarde')),
                  );
                }
                Navigator.of(context).pop();
              },
              style: WelcomeStyles.buttonStyle,
              child: const Text("Unirme"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  void _createTanda() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Crear tanda"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              entradaNombre(),
              entradaIntegrantes(),
              entradaMonto(),
              entradaCodigo()
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String nombre = _textControllerName.text;
                String codigo = _textControllerCodigo.text;
                try {
                  int inte = int.parse(_textControllerInt.text);
                  double monto = double.parse(_textControllerMonto.text);
                  TandaManager.instance.crearTanda(
                      "legna246.dav@gmail.com", nombre, inte, monto, codigo);
                  Navigator.of(context).pop();
                  clearControllers();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tanda creada con éxito')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingresa un número válido')),
                  );
                }
              },
              style: WelcomeStyles.buttonStyle,
              child: const Text("Crear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

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
        title: Text("Mis Tandas",
            style: AppTheme.lightTheme.textTheme.headlineMedium),
        actions: [
          TextButton(
              onPressed: () {
                _unirseTanda();
              },
              child: const Text("Código"))
        ],
      ),
      body: Stack(children: [
        StreamBuilder<List<Tanda>>(
          stream: TandaManager.instance.obtenerTandas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay tandas disponibles"));
            } else {
              List<Tanda> tandas = snapshot.data!;
              return ListView.builder(
                itemCount: tandas.length,
                itemBuilder: (context, index) {
                  Tanda tanda = tandas[index];
                  return ListTile(
                    leading: const IconTheme(
                        data: IconThemeData(color: Colors.blue),
                        child: Icon(Icons.payment)),
                    title: Text(tanda.nombre),
                    subtitle: Text("Admin: ${tanda.admin}"),
                    trailing: Text("Monto: \$${tanda.monto}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(tanda: tanda),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: () {
                  _createTanda();
                },
                child: const Row(
                  children: [Icon(Icons.add), Text("Nueva")],
                )))
      ]),
    );
  }

  TextField entradaNombre() {
    return TextField(
      controller: _textControllerName,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Dale un nombre a tu tanda',
      ),
    );
  }

  TextField entradaIntegrantes() {
    return TextField(
      controller: _textControllerInt,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Número de integrantes',
      ),
    );
  }

  TextField entradaMonto() {
    return TextField(
      controller: _textControllerMonto,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Monto por cada integrante',
      ),
    );
  }

  TextField entradaCodigo() {
    return TextField(
      controller: _textControllerCodigo,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Crea un código para esta tanda',
      ),
    );
  }

  void clearControllers() {
    _textControllerCodigo.clear();
    _textControllerName.clear();
    _textControllerInt.clear();
    _textControllerMonto.clear();
  }
}
