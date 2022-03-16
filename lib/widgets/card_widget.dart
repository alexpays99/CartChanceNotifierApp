import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CardModel>(context);
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
                itemCount: cartItem.cardItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Row(
                      children: [
                        Text(cartItem.cardItems[index].title, style: textTheme),
                        Expanded(child: Container()),
                        Text('\$${cartItem.cardItems[index].price}',
                            style: textTheme),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              Provider.of<CardModel>(context, listen: false)
                                  .removeItem(cartItem.cardItems[index]);
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
                    "Total price: \$${cartItem.totalPrice}",
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
                    "Download file: ",
                    style: textTheme,
                  ),
                ),
              )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Icon(Icons.download),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey),),
                    onPressed: () {},
                  )),
            ],
          )
        ],
      ),
    );
  }
}
