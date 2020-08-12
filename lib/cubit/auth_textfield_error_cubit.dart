import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_textfield_error_state.dart';

class AuthTextfieldErrorCubit extends Cubit<AuthTextfieldErrorState> {
  AuthTextfieldErrorCubit() : super(AuthTextfieldErrorInitial());

  showLoginEmailError(String message){
    emit(LoginEmailTextfieldError(message));
  }

  showLoginPswdError(String message){
    emit(LoginPswdTextfieldError(message));
  }

  showSignUpEmailError(String message){
    emit(SignUpEmailTextfieldError(message));
  }

  showSignUpPswdError(String message){
    emit(SignUpPswdTextfieldError(message));
  }

  showSignUpConfPswdError(String message){
    emit(SignUpConfPswdTextfieldError(message));
  }

  showSignUpFNameError(String message){
    emit(SignUpFNameTextfieldError(message));
  }

  showSignUpLNameError(String message){
    emit(SignUpLNameTextfieldError(message));
  }

}
