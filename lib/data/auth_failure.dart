import 'package:firebase_auth/firebase_auth.dart';

class AuthFailure {
  final FirebaseAuthException exception;

  const AuthFailure(this.exception);

  String checkException() {
    if (exception.code == "auth/user-not-found") {
      return 'There is no account registered on this email';
    } else if (exception.code == 'user-not-found' ||
        exception.code == 'wrong-password') {
      return "Email and password don't match.\nCheck your email and password!";
    } else if (exception.code == 'email-already-in-use') {
      return 'Account has already been created with this email!';
    } else {
      return 'Something went wrong.';
    }
  }
}
