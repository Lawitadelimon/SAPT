import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sapt/screens/home_screen.dart';
import 'package:sapt/screens/listTandas_screen.dart';
import 'package:sapt/screens/login_screen.dart';
import 'package:sapt/services/tanda_manager.dart';
import 'package:sapt/themes/apptheme.dart';
import 'package:sapt/themes/welcome_styles.dart';

class OtherListTandasScreen extends StatefulWidget {
  const OtherListTandasScreen({super.key});

  @override
  State<OtherListTandasScreen> createState() => _OtherListTandasScreenState();
}

class _OtherListTandasScreenState extends State<OtherListTandasScreen> {
  List<Tanda> _tandas = [];

  @override
  void initState() {
    super.initState();
    // Registrar el listener al iniciar la pantalla
    TandaManager.instance.agregarListener(_actualizarTandas);
    // Comenzar a observar tandas
    TandaManager.instance
        .observarTandas(FirebaseAuth.instance.currentUser!.email!);
    // try {
    //   // Aquí llamas a tu lógica para obtener tandas
    //   TandaManager.instance
    //       .obtenerTandas(FirebaseAuth.instance.currentUser!.email!);
    //   print("Stream de tandas inicializado correctamente.");
    // } catch (e, stackTrace) {
    //   print("Error al inicializar el stream de tandas: $e");
    //   print("Stack trace: $stackTrace");
    // }
  }

  @override
  void dispose() {
    // Remover el listener al salir de la pantalla
    TandaManager.instance.removerListener(_actualizarTandas);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              ListTile(
                leading: IconTheme(
                    data: AppTheme.lightTheme.iconTheme,
                    child: const Icon(Icons.payments)),
                title: const Text("Mis tandas"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListTandasScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: IconTheme(
                    data: AppTheme.lightTheme.iconTheme,
                    child: const Icon(Icons.payments)),
                title: const Text("Tandas a las que pertenezco"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtherListTandasScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: IconTheme(
                    data: AppTheme.lightTheme.iconTheme,
                    child: const Icon(Icons.logout)),
                title: const Text("Cerrar sesión"),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white),
        title: Text("Soy parte de:",
            style: AppTheme.lightTheme.textTheme.headlineMedium),
        actions: [
          TextButton(
              onPressed: () {
                _unirseTanda();
              },
              child: const Text("Código"))
        ],
      ),
      body: StreamBuilder<List<Tanda>>(
        stream: TandaManager.instance
            .obtenerTandasPert(FirebaseAuth.instance.currentUser!.displayName!),
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
    );
  }

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
                if (await TandaManager.instance.unirseATanda(
                    codigoController.text,
                    FirebaseAuth.instance.currentUser!.displayName!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Te has unido a la tanda.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Ha ocurrido un error. Intenta de nuevo más tarde.')),
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
}
