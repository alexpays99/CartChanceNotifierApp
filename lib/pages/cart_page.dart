import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/widgets/card_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline1;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cart',style: textTheme)),
      ),
      body: Column(
        children: [
           const CardWidget(),
        ],
      ),
      
    );
  }
}