import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  void setItems(List<String> newItems) {
    _items = newItems;
    notifyListeners(); // Notifica a los observadores que hubo un cambio.
  }
}
