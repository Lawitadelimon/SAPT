import 'package:flutter/material.dart';

class PagosModel extends ChangeNotifier {
  List<String> _pagosPendientes = []; // Lista de pagos pendientes

  List<String> get pagosPendientes => List.unmodifiable(_pagosPendientes);

  void agregarPago(String pago) {
    _pagosPendientes.add(pago); // Agrega un nuevo pago
    notifyListeners();          // Notifica a los widgets suscritos
  }

  void eliminarPago(int index) {
    _pagosPendientes.removeAt(index); // Elimina un pago
    notifyListeners();                // Notifica a los widgets suscritos
  }
}
