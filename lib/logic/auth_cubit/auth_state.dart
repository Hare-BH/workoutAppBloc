part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class SignedOut extends AuthState {
  const SignedOut();
}

class SigningIn extends AuthState {
  final String email;
  final String password;

  const SigningIn(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [email, password];
}

class SignedIn extends AuthState {
  const SignedIn();
}

class SigningUp extends AuthState {
  final String email;
  final String password;

  const SigningUp(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [email, password];
}

class ResetPassword extends AuthState {
  const ResetPassword();
}

class SendingResetPassword extends AuthState {
  const SendingResetPassword();
}

class ResetPasswordSent extends AuthState {
  const ResetPasswordSent();
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
