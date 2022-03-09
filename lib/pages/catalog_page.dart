import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/pages/cart_page.dart';
import 'package:flutter_change_notifier_app/widgets/catalog_list_widget.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline1;
    final titleController = TextEditingController();
    final priceController = TextEditingController();

    void addToCatalog(String title, double price) {

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
                    decoration: const InputDecoration(
                        labelText: 'Price', border: OutlineInputBorder())),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    //addToCatalog(titleController.toString(), priceController);
                  },
                  child: Container(
                    width: 50, 
                    child: const Center(
                      child: Text('Add')
                    ),
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
