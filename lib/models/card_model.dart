import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';

class CardModel extends ChangeNotifier {
  late Item _item;
  final List<Item> _items = [];
  UnmodifiableListView<Item> get cardItems => UnmodifiableListView(_items);

  Item get item => _item;

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  double get totalPrice => cardItems.fold(0, (total, current) => total + current.price);
}
