import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/pages/catalog_page.dart';
import 'package:flutter_change_notifier_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(); // email controller
    TextEditingController passwordController =
        TextEditingController(); // password controller
    GlobalKey formKey = GlobalKey<FormState>();

    @override
    void initState() {
      super.initState();
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // text field for email
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.amber,
                            )),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      // text field for password
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            icon: Icon(
                              Icons.password,
                              color: Colors.amber,
                            )),
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 25,
                  child: ElevatedButton(
                    child: const Text('Sign in'),
                    onPressed: () {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      if(email.isEmpty) {
                        print('email is empty');
                      }
                      else {
                        if (password.isEmpty) {
                          print('password is empty');
                        }
                        else {
                          context.read<AuthService>().login(email, password);
                          Navigator.pushReplacementNamed(context, '/catalog');
                        }
                      }
                      
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 25,
                  child: ElevatedButton(
                    child: const Text('Sign up'),
                    onPressed: () {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      if(email.isEmpty) {
                        print('email is empty');
                      }
                      else {
                        if (password.isEmpty) {
                          print('password is empty');
                        }
                        else {
                          context.read<AuthService>().signUp(email, password);
                          context.read<AuthService>().addToCollection(email, password);
                          Navigator.pushReplacementNamed(context, '/catalog');
                        }
                      }
                      
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Center(
                  child: Row(
                    children: [
                      // sign-up if account not exist
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Sign-up',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      // recovery forgoten password
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // Center(
              //   child: Text('User id: ${AuthService().currentUser?.uid}'),
              // )
            ],
          ),
        ),
      )),
    );
  }
}
