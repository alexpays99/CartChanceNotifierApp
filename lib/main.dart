import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:flutter_change_notifier_app/pages/catalog_page.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';

void main() {
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => CardModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => ItemModel(),
    ),
  ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const CatalogPage(),
    );
  }
}
