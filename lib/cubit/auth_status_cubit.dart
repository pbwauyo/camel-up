import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_status_state.dart';

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit() : super(AuthStatusInitial());

  loginSucess(){
    emit(AuthLoggedInSuccess());
  }

  signUpSuccess(){
    emit(AuthSignUpSuccess());
  }

  loadingStatus(){
    emit(AuthLoading());
  }

  loadedStatus(){
    emit(AuthLoaded());
  }
}

