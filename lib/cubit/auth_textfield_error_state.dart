part of 'auth_textfield_error_cubit.dart';

abstract class AuthTextfieldErrorState extends Equatable {
  const AuthTextfieldErrorState();
}

class AuthTextfieldErrorInitial extends AuthTextfieldErrorState {
  @override
  List<Object> get props => [];
}

class LoginEmailTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const LoginEmailTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginPswdTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const LoginPswdTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpEmailTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const SignUpEmailTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpPswdTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const SignUpPswdTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpConfPswdTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const SignUpConfPswdTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpLNameTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const SignUpLNameTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpFNameTextfieldError extends AuthTextfieldErrorState{
  final String message;

  const SignUpFNameTextfieldError(this.message);

  @override
  List<Object> get props => [message];
}



