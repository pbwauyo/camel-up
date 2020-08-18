part of 'enter_role_cubit.dart';

abstract class EnterRoleState extends Equatable {
  const EnterRoleState();
}

class EnterRoleInitial extends EnterRoleState {
  const EnterRoleInitial();
  @override
  List<Object> get props => [];
}

class EnterRoleActive extends EnterRoleState {
  const EnterRoleActive();
  @override
  List<Object> get props => [];
}

class EnterRoleDone extends EnterRoleState {
  final String role;
  EnterRoleDone({@required this.role});

  @override
  List<Object> get props => [];
}
