import 'package:bloc/bloc.dart';

import 'package:camel_up/cubit/auth_status_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo _userRepo;

  AuthCubit(this._userRepo) : super(AuthInitial());

  Future checkSignedInUser() async {
    try{
      final user = await _userRepo.getCurrentUser();
      if(user != null){
        emit(AuthLoggedIn(user.email));
      }else{
        emit(AuthLoggedOut());
      }
    }catch(error){
      print("CHECK SIGNED USER ERROR: $error");
      emit(AuthLoggedOut());
    }
  }

  Future signUpUser(BuildContext context,  Profile profile) async {
    try{
      final authStatusCubit = context.bloc<AuthStatusCubit>();
      authStatusCubit.loadingStatus();
      await _userRepo.createNewUser(profile);
      authStatusCubit.signUpSuccess();
      emit(AuthSignedUp());
    }catch(error){
      emit(AuthSignUpError("$error"));
    }
  }

  Future loginUser(BuildContext context, String email, String password) async {
    try{
      final authStatusCubit = context.bloc<AuthStatusCubit>();
      authStatusCubit.loadingStatus();
      await _userRepo.loginUser(email, password);
      authStatusCubit.loginSucess();
      emit(AuthLoggedIn(email));
    }catch(error){
      emit(AuthError("$error"));
    }
  }

  Future logoutUser() async {
    try{
      await _userRepo.logoutUser();
      emit(AuthLoggedOut());
    }catch(error){
      emit(AuthError("Error while logging out"));
    }
  }

  goToSignup(){
    emit(AuthSignUp());
  }

  goToLogin(){
    emit(AuthLogIn());
  }

  goToHome(){
    _userRepo.getCurrentUserEmail()
    .then((email) => emit(AuthLoggedIn(email))) ;
  }

}
