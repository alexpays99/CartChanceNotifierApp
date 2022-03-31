import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/widgets/auth_widget.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.headline1;

    return Scaffold(
      body: const AuthWidget(),
    );
  }
}
