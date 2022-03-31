import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:flutter_change_notifier_app/pages/auth_page.dart';
import 'package:flutter_change_notifier_app/pages/cart_page.dart';
import 'package:flutter_change_notifier_app/pages/catalog_page.dart';
import 'package:flutter_change_notifier_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemModel(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: []),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth Screen',
        theme: appTheme,
        home: const AuthWrapper(),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const AuthWrapper(),
          '/catalog': (context) => const CatalogPage(),
          '/cart': (context) => const CartPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return const CatalogPage();
    }
    return const AuthPage();
  }
}
