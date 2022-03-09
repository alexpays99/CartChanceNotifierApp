import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:flutter_change_notifier_app/pages/cart_page.dart';
import 'package:flutter_change_notifier_app/widgets/catalog_list_widget.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    final catalogItem = Provider.of<ItemModel>(context);
    var textTheme = Theme.of(context).textTheme.headline1;
    var titleController = TextEditingController();
    var priceController = TextEditingController();

    @override
    void dispose() {
      titleController.dispose();
      priceController.dispose();
      super.dispose();
    }

    void addToCatalog(
        TextEditingController titleController,
        TextEditingController priceController,
        ItemModel catalogItem,
        BuildContext context) {
      String title = titleController.text;
      double price = double.parse(priceController.text);
      catalogItem.item.title = title;
      catalogItem.iitem.price = price;
      final item = Item(catalogItem.item.title, catalogItem.iitem.price);
      Provider.of<ItemModel>(context, listen: false).add(item);
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Catalog', style: textTheme)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(Icons.shopping_cart),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8.0),
              ),
              //const CardWidget(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Row(
                  children: [
                    const Text('Items: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        )),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Title', border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Price', border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addToCatalog(
                      titleController, priceController, catalogItem, context);
                },
                child: Container(
                  width: 50,
                  child: const Center(child: Text('Add')),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CatalogListWidget(),
            ],
          ),
        ));
  }
}
