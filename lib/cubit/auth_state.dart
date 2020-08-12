part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class AuthLoggedIn extends AuthState{
  final String email;
  AuthLoggedIn(this.email);

  @override
  List<Object> get props => [email];
}

class AuthLoggedOut extends AuthState{
  const AuthLoggedOut();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthState{
  const AuthSignUp();

  @override
  List<Object> get props => [];
}

class AuthSignUpError extends AuthState{
  final String message;
  const AuthSignUpError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthSignedUp extends AuthState{
  const AuthSignedUp();

  @override
  List<Object> get props => [];
}

class AuthLogIn extends AuthState{
  const AuthLogIn();

  @override
  List<Object> get props => [];
}

class AuthError extends AuthState{
  final String message;
  AuthError(this.message);

  @override
  List<Object> get props => [message];
}

