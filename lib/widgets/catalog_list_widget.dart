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
    final itemModel = Provider.of<ItemModel>(context);
    final cartModel = Provider.of<CardModel>(context);
    final iconAdd = Icon(Icons.add); // adds to cart
    final iconRemove = Icon(Icons.remove); // removes from catalog
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
          child: StreamBuilder(
            stream: itemModel.firebaseItems.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return (snapshot.hasData)
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
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
                                    height: 112,
                                    width: 50,
                                    color:
                                        const Color.fromRGBO(255, 235, 59, 1),
                                    child: Consumer<ItemModel>(
                                      builder: ((context, value, child) {
                                        return IconButton(
                                            onPressed: () {
                                              Item item = Item(
                                                  doc!['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6.0),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            iconSize: 20.0,
                                            onPressed: () {
                                              Item item = Item(
                                                  doc['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);

                                              Provider.of<CardModel>(context,
                                                              listen: false)
                                                          .counter >=
                                                      0
                                                  ? Provider.of<CardModel>(
                                                          context,
                                                          listen: false)
                                                      .removeItem(cartModel
                                                          .cardItems[index])
                                                  : 0;

                                              Provider.of<CardModel>(context,
                                                              listen: false)
                                                          .counter >=
                                                      0
                                                  ? Provider.of<CardModel>(
                                                          context,
                                                          listen: false)
                                                      .counter--
                                                  : 0;

                                              setState(() {
                                                item.amount--;
                                                Provider.of<ItemModel>(context,
                                                        listen: false)
                                                    .updateCatalog(item);
                                              });
                                            },
                                            icon: const Icon(Icons.remove)),

                                        // Expanded(child: Container()),
                                        // Consumer<CardModel>(
                                        //   builder: ((context, value, child) {
                                        //     return Text(
                                        //         counter.toString(),
                                        //         style: Theme.of(context)
                                        //             .textTheme
                                        //             .bodyMedium);
                                        //   }),
                                        // ),
                                        // Expanded(child: Container()),
                                        Text(doc['amount'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        IconButton(
                                            iconSize: 20.0,
                                            onPressed: () {
                                              Item item = Item(
                                                  doc['id'],
                                                  doc['name'],
                                                  doc['price'],
                                                  doc['amount']);

                                              Provider.of<CardModel>(context,
                                                      listen: false)
                                                  .add(item);

                                              Provider.of<CardModel>(context,
                                                      listen: false)
                                                  .counter++;

                                              setState(() {
                                                item.amount++;
                                                Provider.of<ItemModel>(context,
                                                        listen: false)
                                                    .updateCatalog(item);
                                              });
                                            },
                                            icon: const Icon(Icons.add)),
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
