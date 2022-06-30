import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workouts_app_bloc/database/authentication.dart';
import 'package:workouts_app_bloc/database/db.dart';
import '../../data/auth_failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Authentication auth;
  final WorkoutRepository db;

  AuthCubit(this.auth, this.db) : super(const SignedOut());

  Future<void> userSingIn(String email, String password) async {
    emit(SigningIn(email, password));
    final Either<AuthFailure, UserCredential> userOrException =
        await auth.signIn(email, password);
    userOrException.fold(
      (exception) {
        emit(const SignedOut());
        emit(AuthError(
          exception.checkException(),
        ));
      },
      (userCredential) async {
        Authentication.uid = userCredential.user!.uid;
        Authentication.username = userCredential.user!.displayName!;
        emit(const SignedIn());
      },
    );
  }

  Future<void> userSingUp({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(SigningUp(email, password));
    final Either<AuthFailure, UserCredential> userOrException =
        await auth.register(email, password);
    userOrException.fold(
      (exception) {
        emit(const SignedOut());
        emit(AuthError(
          exception.checkException(),
        ));
      },
      (userCredential) async {
        await userCredential.user!.updateDisplayName(username);
        Authentication.uid = userCredential.user!.uid;
        Authentication.username = username;
        emit(const SignedIn());
      },
    );
  }

  Future<void> userSignOut() async {
    Authentication.uid = 'default';
    await auth.signOut();
    emit(const SignedOut());
  }

  Future<void> sendPasswordResetEmail(String email) async {
    emit(const SendingResetPassword());
    final Either<AuthFailure, void> sentEmail =
        await auth.sendPasswordResetEmail(email);
    sentEmail.fold(
      (exception) {
        emit(const ResetPassword());
        emit(AuthError(
          exception.checkException(),
        ));
      },
      (sent) {
        emit(const ResetPasswordSent());
      },
    );
    emit(const ResetPasswordSent());
  }
}
