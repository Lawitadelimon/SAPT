import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TandaManager extends ChangeNotifier {
  TandaManager._privateConstructor();
  // Instancia Singleton
  static final TandaManager _instance = TandaManager._internal();

  factory TandaManager() {
    return _instance;
  }

  TandaManager._internal() {
    _init();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Tanda> _tandas = [];

  List<Tanda> get tandas => _tandas;

  // Inicializar escuchando cambios en Firestore
  void _init() {
    _firestore.collection('tandas').snapshots().listen((snapshot) {
      _tandas = snapshot.docs.map((doc) => Tanda.fromFirestore(doc)).toList();
      notifyListeners(); // Notifica a los observadores (widgets)
    });
  }

  static DocumentReference<Map<String, dynamic>> getTandaRef(String tandaId) {
    return FirebaseFirestore.instance.collection('tandas').doc(tandaId);
  }

  // Crear una nueva tanda
  Future<void> crearTanda(String admin, String nombre, int inte, double monto,
      String codigo) async {
    await _firestore.collection('tandas').add({
      'admin': admin,
      'nombre': nombre,
      'inte': inte,
      'monto': monto,
      'codigo': codigo,
      'participantes': [],
      'turnoActual': null,
    });
    // No es necesario llamar a notifyListeners aquí, ya que Firestore lo hace automáticamente
  }

  // Unirse a una tanda
  Future<void> unirseATanda(String tandaId, String usuarioNombre) async {
    DocumentReference tandaRef = _firestore.collection('tandas').doc(tandaId);
    DocumentSnapshot tandaSnapshot = await tandaRef.get();
    if (tandaSnapshot.exists) {
      List<dynamic> usuarios = tandaSnapshot['usuarios'];
      if (!usuarios.contains(usuarioNombre)) {
        usuarios.add(usuarioNombre);
        await tandaRef.update({'usuarios': usuarios});
        // notifyListeners no es necesario aquí
      }
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

  // Actualizar el monto semanal de una tanda
  Future<void> actualizarMontoSemanal(String tandaId, double nuevoMonto) async {
    await _firestore
        .collection('tandas')
        .doc(tandaId)
        .update({'montoSemanal': nuevoMonto});
    // notifyListeners no es necesario aquí
  }

  // Avanzar al siguiente turno
  Future<void> avanzarTurno(String tandaId) async {
    DocumentReference tandaRef = _firestore.collection('tandas').doc(tandaId);
    DocumentSnapshot tandaSnapshot = await tandaRef.get();
    if (tandaSnapshot.exists) {
      Map<String, dynamic> data = tandaSnapshot.data() as Map<String, dynamic>;
      List<dynamic> usuarios = data['usuarios'];
      String? turnoActual = data['turnoActual'];
      if (usuarios.isNotEmpty) {
        int currentIndex = usuarios.indexOf(turnoActual);
        int nextIndex = (currentIndex + 1) % usuarios.length;
        String nextTurn = usuarios[nextIndex];
        await tandaRef.update({'turnoActual': nextTurn});
      }
    }
  }
}

// Clase para representar una Tanda
class Tanda {
  final String id;
  final String admin;
  final String nombre;
  final int integrantes;
  final double monto;
  final List<String> participantes;
  final String? turnoActual;

  Tanda(
      {required this.id,
      required this.admin,
      required this.nombre,
      required this.integrantes,
      required this.monto,
      required this.participantes,
      this.turnoActual});

  // Crear una tanda desde Firebase
  factory Tanda.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Tanda(
        id: doc.id,
        admin: data['admin'],
        nombre: data['nombre'],
        integrantes: data['integrantes'],
        monto: data['monto'],
        participantes: List<String>.from(data['participantes']),
        turnoActual: data['turnoActual']);
  }
}
