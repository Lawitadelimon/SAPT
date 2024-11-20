import 'package:cloud_firestore/cloud_firestore.dart';

class TandaManager {
  TandaManager._privateConstructor();
  static final TandaManager _instance = TandaManager._privateConstructor();

  // Acceder a la instancia única
  static TandaManager get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Crear una nueva tanda y guardarla en Firebase
  Future<void> crearTanda(String admin, String nombre, int integrantes,
      double monto, String codigo) async {
    // ignore: unused_local_variable
    DocumentReference tandaRef = await _firestore.collection('tandas').add({
      'admin': admin,
      'nombre': nombre,
      'integrantes': integrantes,
      'monto': monto,
      'codigo': codigo,
      'participantes': [],
    });
    print("Tanda '${nombre}' creada exitosamente en Firebase.");
  }

  // Unirse a una tanda y actualizarla en Firebase
  Future<void> unirseATanda(String codigo, String usuario) async {
    QuerySnapshot tandaQuery = await _firestore
        .collection('tandas')
        .where('codigo', isEqualTo: codigo)
        .get();

    if (tandaQuery.docs.isNotEmpty) {
      var tandaDoc = tandaQuery.docs.first;
      List participantes = List.from(tandaDoc['participantes']);
      if (!participantes.contains(usuario)) {
        participantes.add(usuario);
        await tandaDoc.reference.update({
          'participantes': participantes,
        });
        print("${usuario} se unió a la tanda '$codigo'.");
      } else {
        print("${usuario} ya está en la tanda '$codigo'.");
      }
    } else {
      print("La tanda '$codigo' no existe.");
    }
  }

  // Obtener todas las tandas activas
  Stream<List<Tanda>> obtenerTandas() {
    return _firestore
        .collection('tandas')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Tanda.fromFirestore(doc);
            }).toList());
  }
}

// Clase para representar una Tanda
class Tanda {
  final String admin;
  final String nombre;
  final int integrantes;
  final double monto;
  final List<String> participantes;

  Tanda({
    required this.admin,
    required this.nombre,
    required this.integrantes,
    required this.monto,
    required this.participantes,
  });

  // Crear una tanda desde Firebase
  factory Tanda.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Tanda(
      admin: data['admin'],
      nombre: data['nombre'],
      integrantes: data['integrantes'],
      monto: data['monto'],
      participantes: List<String>.from(data['participantes']),
    );
  }
}

// Clase para representar un Usuario
class Usuario {
  final String nombre;
  final String email;

  Usuario({required this.nombre, required this.email});
}
