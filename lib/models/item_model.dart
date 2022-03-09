import 'package:flutter/cupertino.dart';

class ItemModel extends ChangeNotifier{
  late Item item = Item('title', 12.0);
  final List<Item> items = [
    // Item('Code Smell', 19.0),
    // Item('Control Flow', 20.0),
    // Item('Sprint', 21.0),
    // Item('Heisenbug', 22.0),
    // Item('Spaghetti', 23.0),
    // Item('Hydra Code', 24.1),
    // Item('Scope', 25.5),
    // Item('Callback', 29.5),
    // Item('Closure', 55.5),
    // Item('Automata', 45.5),
    // Item('Bit Shift', 12.0),
    // Item('Currying', 100.0),
  ];

  Item get iitem => item;

  //set item (Item item) => _item =item;

  void add(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromCatalog(Item item) {
    items.remove(item);
    notifyListeners();
  }
}

class Item {
  String title;
  double price;

  Item(this.title, this.price);
}