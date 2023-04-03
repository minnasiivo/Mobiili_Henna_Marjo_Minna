import 'dart:collection';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:weather_app/globals.dart';
import 'package:weather_app/logic/models/weather_model.dart';

import '../../data/firebase_helper.dart';

class WeatherListManager extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<WeatherModel> _items = [];
  final fbHelper = FirebaseHelper();

  WeatherListManager();

  Future<void> init() async {
    // loadFromdb();
    loadFromFirebase();
  }

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<WeatherModel> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(WeatherModel item) {
    log("Lisää uusi item");
    _items.add(item);

    fbHelper.saveWeather(item);

    //  dbHelper.insert(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    //_items.remove(TodoItem('Ensimmäinen tehtävä', 'Tehtävän kuvaus', DateTime.parse('2023-01-01'), false));
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  WeatherModel? getItem(int index) {
    if (_items.length > index && index >= 0) {
      return _items[index];
    }
    return null;
  }

  void editItem(int index, WeatherModel item) {
    if (_items.length > index && index >= 0) {
      _items[index] = item;
      dbHelper.update(item);
      notifyListeners();
    }
  }

  void deleteItem(WeatherModel item) {
    dbHelper.delete(item.id);
    _items.remove(item);
    notifyListeners();
  }

  void loadFromdb() async {
    final list = await dbHelper.queryAllRows();
    for (WeatherModel item in list) {
      _items.add(item);
    }
    notifyListeners();
  }

  loadFromFirebase() async {
    final list = await fbHelper.getData();
    for (WeatherModel item in list) {
      _items.add(item);
    }
    notifyListeners();
  }
}
