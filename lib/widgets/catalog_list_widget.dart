import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:provider/provider.dart';

class CatalogListWidget extends StatelessWidget {
  const CatalogListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemModel = ItemModel();
    final iconAdd = Icon(Icons.add);
    final iconAdded = Icon(Icons.check);
    final bool _isChecked = false;
    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context)
              .size
              .width, // занимает всю свободную ширину экрана
          color: const Color.fromARGB(82, 205, 243, 33),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            itemCount: itemModel.items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = itemModel.items[
                  index]; // переменная с конкретным текущим елементом, который должен отображаться

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          //color: const Color.fromARGB(255, 45, 226, 75),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                            decoration: const BoxDecoration(
                              //color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(item.title, //item.title,
                                  style: textTheme),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Text('\$${item.price}', //item.title,
                              style: textTheme),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              _isChecked == !_isChecked;
                              Provider.of<CardModel>(context, listen: false)
                                  .add(item);
                            },
                            icon: iconAdd),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

