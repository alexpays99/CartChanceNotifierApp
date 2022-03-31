import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:provider/provider.dart';

class CatalogListWidget extends StatefulWidget {
  const CatalogListWidget({Key? key}) : super(key: key);

  @override
  State<CatalogListWidget> createState() => _CatalogListWidgetState();
}

class _CatalogListWidgetState extends State<CatalogListWidget> {
  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<ItemModel>(context); // have access to ItemModel
    final cartModel = Provider.of<CardModel>(context); // have access to CardModel
    final iconAdd = Icon(Icons.add); // adds to cart
    final iconRemove = Icon(Icons.remove, color: Colors.white); // removes from catalog
    var textTheme = Theme.of(context).textTheme.headline6;

    @override
    void initState() {
      super.initState();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(82, 205, 243, 33),
          // stream for snapsots from firestore
          child: StreamBuilder(
            stream:
                itemModel.firebaseItems.snapshots(), // used stream of stapshots
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // if exist some data in firestore, stream returns list of existing data, else it's shows circular progressing indicator.
              return (snapshot.hasData)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 8.0),
                      itemCount: snapshot.data?.docs.length, // amount of items in firestore
                      itemBuilder: (context, int index) {
                        QueryDocumentSnapshot<Object?>? doc = snapshot.data?.docs[index]; // access to each item by its index

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 112,
                                    width: 50,
                                    color:
                                        const Color.fromRGBO(255, 235, 59, 1),
                                        // Shows actual item from firestore by its index
                                    child: Consumer<ItemModel>(
                                      builder: ((context, value, child) {
                                        return IconButton(
                                            onPressed: () {
                                              // put data from stapsot to instance of item
                                              Item item = Item(
                                                  doc!['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);
                                              itemModel.removeFromCatalog(item); // remove item from list of items in catalog
                                            },
                                            icon: iconRemove);
                                      }),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      decoration: const BoxDecoration(
                                          //color: Colors.white,
                                          ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Text(doc!['name'], // show item title from snapshot
                                            style: textTheme),
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text('\$${doc['price']}', // show item price from snapshot
                                        style: textTheme),
                                  ),
                                  Expanded(child: Container()),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            iconSize: 20.0,
                                            onPressed: () {
                                              // put data from stapsot to instance of item
                                              Item item = Item(
                                                  doc['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);
                                              // removes existed items in cart while its amount > 0
                                              Provider.of<CardModel>(context, listen: false).counter >= 0
                                                  ? Provider.of<CardModel>(context,listen: false).removeItem(cartModel.cardItems[index])
                                                  : 0;

                                              // decreacing counter of added items in cart while its amount > 0
                                              Provider.of<CardModel>(context,listen: false).counter >=0
                                                  ? Provider.of<CardModel>(context,listen: false).counter--
                                                  : 0;

                                              // decreace amount of item and update this value in firestore
                                              setState(() {
                                                item.amount >= 0
                                                    ? item.amount--
                                                    : 0;
                                                Provider.of<ItemModel>(context,listen: false).updateCatalog(item); // update changed value in firestore
                                              });
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white)),
                                        Text(
                                          doc['amount'].toString(),
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        IconButton(
                                            iconSize: 20.0,
                                            onPressed: () {
                                              // put data from stapsot to instance of item
                                              Item item = Item(
                                                  doc['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);

                                              // add item in cart 
                                              Provider.of<CardModel>(context,listen: false).add(item);

                                              // incereace counter of added items in cart 
                                              Provider.of<CardModel>(context,listen: false).counter++;
                                              
                                              // incereacing counter of added items in cart and update this value in firestore
                                              setState(() {
                                                item.amount++;
                                                Provider.of<ItemModel>(context,listen: false).updateCatalog(item); // update changed value in firestore
                                              });
                                            },
                                            icon: const Icon(Icons.add,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(
                        value: 2.0,
                        color: Colors.blue,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
