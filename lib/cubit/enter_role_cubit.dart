import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'enter_role_state.dart';

class EnterRoleCubit extends Cubit<EnterRoleState> {
  EnterRoleCubit() : super(EnterRoleInitial());

  startEnterRole(){
    emit(EnterRoleActive());
  }

  stopEnterRole(String role){
    emit(EnterRoleDone(role: role));
  }

  resetEnterRole(){
    emit(EnterRoleInitial());
  }
}
