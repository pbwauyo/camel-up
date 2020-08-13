part of 'auth_status_cubit.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();
}

class AuthStatusInitial extends AuthStatusState {
  @override
  List<Object> get props => [];
}

class AuthLoggedInSuccess extends AuthStatusState{
  const AuthLoggedInSuccess();
  
  @override
  List<Object> get props => [];
}

class AuthSignUpSuccess extends AuthStatusState{
  const AuthSignUpSuccess();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthStatusState{
  const AuthLoading();

  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthStatusState{
  const AuthLoaded();

  @override
  List<Object> get props => [];
}
