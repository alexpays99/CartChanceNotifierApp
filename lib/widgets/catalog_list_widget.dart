import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:provider/provider.dart';

class CatalogListWidget extends StatelessWidget {
  const CatalogListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemModel = Provider.of<ItemModel>(context);
    final iconAdd = Icon(Icons.add); // adds to cart
    final iconRemove = Icon(Icons.remove); // removes from catalog
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(82, 205, 243, 33),
          child: StreamBuilder(
            stream: itemModel.firebaseItems.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return (snapshot.hasData)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      //shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 8.0),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, int index) {
                        QueryDocumentSnapshot<Object?>? doc =
                            snapshot.data?.docs[index];

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
                                    height: 100,
                                    width: 50,
                                    color:
                                        const Color.fromARGB(255, 255, 230, 0),
                                    child: Consumer<ItemModel>(
                                      builder: ((context, value, child) {
                                        return IconButton(
                                            onPressed: () {
                                              Item item = Item(doc!['id'],
                                                  doc['name'], doc['price']);
                                              itemModel.removeFromCatalog(item);
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
                                        child: Text(doc!['name'], //item.title,
                                            style: textTheme),
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text('\$${doc['price']}',
                                        style: textTheme),
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                      onPressed: () {
                                        Item item = Item(doc['id'], doc['name'],
                                            doc['price']);
                                        Provider.of<CardModel>(context,
                                                listen: false)
                                            .add(item);
                                      },
                                      icon: iconAdd),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const Center(
                      child: Text('Has no data'),
                    );
            },
          ),
        ),
      ),
    );
  }
}
