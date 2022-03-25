import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ItemModel extends ChangeNotifier {
  CollectionReference firebaseItems = FirebaseFirestore.instance.collection('items');
  Item item = Item(Uuid().v4(), 'apple', 20.0, 0);
  final List<Item> items = [];

  void add(Item addItem) {
    //addItem.id = const Uuid().v4.toString();
    //item = Item(addItem.id, addItem.title, addItem.price, addItem.amount);
    items.add(item);
    firebaseItems.add({
      'id': item.id,
      'name': item.title,
      'price': item.price,
      'amount': item.amount
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

  void updateCatalog(Item itemToUpdate) {
    item = Item(itemToUpdate.id, itemToUpdate.title, itemToUpdate.price, itemToUpdate.amount);
    print(itemToUpdate.amount);
    
    firebaseItems.where('id', isEqualTo: itemToUpdate.id).get().then((value) {
      value.docs[itemToUpdate.id.indexOf(itemToUpdate.id)].reference.update({'amount': itemToUpdate.amount}).then((value) => print('successfully updated'));
    });
    notifyListeners();
  }
}

class Item {
  String id = Uuid().v4();
  String title;
  double price;
  int amount = 0;

 
  Item(this.id, this.title, this.price, this.amount);
}
