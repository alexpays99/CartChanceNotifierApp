import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<CardModel>(context);
    var textTheme = Theme.of(context).textTheme.headline6;

    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: item.cardItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Row(
                      children: [
                        Text(item.cardItems[index].title, style: textTheme),
                        Expanded(child: Container()),
                        Text('\$${item.cardItems[index].price}', style: textTheme),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              Provider.of<CardModel>(context, listen: false)
                                  .removeItem(item.cardItems[index]);
                            },
                            icon: const Icon(Icons.remove)),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                //color: Colors.yellow,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total price: \$${item.totalPrice}",
                    style: textTheme,
                  ),
                ),
              )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Buy'),
                    onPressed: () {},
                  )),
            ],
          )
        ],
      ),
    );
  }
}