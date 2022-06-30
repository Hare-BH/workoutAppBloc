import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

import '../data/auth_failure.dart';

class Authentication {
  final FirebaseAuth _auth;

  Authentication({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  get getFirebaseAuthInstance => _auth;

  static String uid = 'default';
  static String username = 'default';

  Future<Either<AuthFailure, UserCredential>> register(
      String email, String password) async {
    try {
      return right(
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e));
    }
  }

  Future<Either<AuthFailure, UserCredential>> signIn(
      String email, String password) async {
    try {
      return right(await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e));
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future<Either<AuthFailure, void>> sendPasswordResetEmail(String email) async {
    try {
      return right(
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email));
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(e));
    }
  }
}

//String uid = 'default';
