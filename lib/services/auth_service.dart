import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  AuthService(this._auth);

  //User? get currentUser => _firebaseAuth.currentUser;

  // Future<User?> getOrCreateUser() async {
  //   if (currentUser == null) {
  //     await _firebaseAuth.signInAnonymously();
  //   }

  //   return currentUser;
  // }

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Loggen in';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addToCollection(String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .set({"uid": user?.uid, "email": email, "password": password});
      return 'Signed up';
    } catch (e) {
      return e.toString();
    }
  }
}
