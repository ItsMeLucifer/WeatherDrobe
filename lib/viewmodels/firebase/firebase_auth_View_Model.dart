import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status { Authenticated, Unauthenticated }

class FireBaseAuthViewModel extends ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseAuth get auth => _auth;
  UserCredential userCredential;
  FireBaseAuthViewModel.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }
  Status _status = Status.Unauthenticated;
  Status get status => _status;
  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  User _user;
  Future<void> signIn(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
