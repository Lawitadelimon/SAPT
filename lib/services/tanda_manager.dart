import 'package:cloud_firestore/cloud_firestore.dart';

typedef TandaListener = void Function(List<Tanda> tandas);

class TandaManager {
  // Singleton
  TandaManager._privateConstructor();
  static final TandaManager _instance = TandaManager._privateConstructor();
  // Acceder a la instancia única
  static TandaManager get instance => _instance;

  // Instancia de Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Implementación de observer
  // Lista de listeners para notificar sobre cambios
  final List<TandaListener> _listeners1 = [];

  // Agregar un listener
  void agregarListener(TandaListener listener) {
    _listeners1.add(listener);
  }

  // Remover un listener
  void removerListener(TandaListener listener) {
    _listeners1.remove(listener);
  }

  // Notificar a todos los listeners
  void _notificarListeners(List<Tanda> tandas) {
    for (var listener in _listeners1) {
      listener(tandas);
    }
  }

  // Obtener tandas y observar cambios en Firebase
  void observarTandas(String admin) {
    _firestore
        .collection('tandas')
        .where('admin',
            isEqualTo:
                admin) // Cambia 'admin' y 'nombreDelAdmin' según lo que necesites
        .snapshots()
        .listen((snapshot) {
      final tandas = snapshot.docs.map((doc) {
        return Tanda.fromFirestore(doc);
      }).toList();
      _notificarListeners(tandas);
    });
  }

  // Crear una nueva tanda y guardarla en Firebase
  Future<void> crearTanda(String admin, String nombre, int integrantes,
      double monto, String codigo) async {
    DocumentReference tandaRef = await _firestore.collection('tandas').add({
      'admin': admin,
      'nombre': nombre,
      'integrantes': integrantes,
      'monto': monto,
      'codigo': codigo,
      'turno': 1,
      'participantes': [],
    });
    print("Tanda '${nombre}' creada exitosamente en Firebase.");
  }

  // Unirse a una tanda y actualizarla en Firebase
  Future<bool> unirseATanda(String codigo, String usuario) async {
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
        return true;
      } else {
        print("${usuario} ya está en la tanda '$codigo'.");
        return false;
      }
    } else {
      print("La tanda '$codigo' no existe.");
      return false;
    }
  }

  // Obtener todas las tandas activas
  Stream<List<Tanda>> obtenerTandas(String admin) {
    return _firestore
        .collection('tandas')
        .where('admin',
            isEqualTo: admin) // Cambia 'admin' y 'nombreDelAdmin' según tu caso
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Tanda.fromFirestore(doc);
            }).toList());
  }

  // Obtener todas las tandas activas
  Stream<List<Tanda>> obtenerTandasPert(String inte) {
    return _firestore
        .collection('tandas')
        .where('participantes',
            arrayContains:
                inte) // Cambia 'nombreDelUsuario' al valor que buscas
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
  final String codigo;
  final int integrantes;
  final double monto;
  final int turno;
  final List<String> participantes;
  Tanda(
      {required this.admin,
      required this.codigo,
      required this.nombre,
      required this.integrantes,
      required this.monto,
      required this.participantes,
      required this.turno});

  // Crear una tanda desde Firebase
  factory Tanda.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Tanda(
      admin: data['admin'],
      codigo: data['codigo'],
      nombre: data['nombre'],
      integrantes: data['integrantes'],
      monto: (data['monto'] is int)
          ? (data['monto'] as int).toDouble()
          : data['monto'], // Conversión de int a double
      turno: data['turno'],
      participantes: List<String>.from(data['participantes']),
    );
  }
}

// Clase para representar un Usuario
// class Usuario {
//   final String nombre;
//   final String email;
//   Usuario({required this.nombre, required this.email});
// }
