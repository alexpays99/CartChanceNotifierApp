import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';

class CardModel extends ChangeNotifier {
  late Item _item;
  final List<Item> _items = [];
  int _counter = 0;

  UnmodifiableListView<Item> get cardItems => UnmodifiableListView(_items);
  Item get item => _item;
  double get totalPrice =>
      cardItems.fold(0, (total, current) => total + current.price);
  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}