import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ItemModel extends ChangeNotifier {
  CollectionReference firebaseItems = FirebaseFirestore.instance.collection('items');
  late Item item = Item(Uuid().v4(), 'apple', 20.0);
  final List<Item> items = [
  ];

  Item get iitem => item;

  void add(Item item) {
    items.add(item);
    firebaseItems.add({
      'id': item.id,
      'name': item.title,
      'price': item.price
    });
    print(item.id.toString());
    notifyListeners();
  }

  void removeFromCatalog(Item itemToRemove) {
    items.remove(itemToRemove);
    print(itemToRemove.id);
    
    firebaseItems.where('id', isEqualTo: itemToRemove.id).get().then((value) {
      value.docs[itemToRemove.id.indexOf(itemToRemove.id)].reference.delete().then((value) => print('successfull deleted'));
    });
    notifyListeners();
  }
}

class Item {
  String id = const Uuid().v4();
  String title;
  double price;
 
  Item(this.id, this.title, this.price);
}
