import 'package:camel_up/cubit/auth_textfield_error_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool emailIsvalid(String email){
  return email.isNotEmpty;
}

bool passwordIsValid(String password){
  return password.isNotEmpty && password.length >= 5;
}

bool nameIsValid(String name){
  return name.isNotEmpty && name.length >= 2;
}

bool signUpFieldsAreValid({@required BuildContext context, @required String fName, 
                          @required String lName, @required String email, 
                          @required String pswd, @required String confPswd}){

    final authTextfieldErrorCubit = context.bloc<AuthTextfieldErrorCubit>();
          

    if(!nameIsValid(fName)){
      authTextfieldErrorCubit.showSignUpFNameError("Invalid name");
      return false;
    }

     if(!nameIsValid(lName)){
      authTextfieldErrorCubit.showSignUpFNameError("Invalid name");
      return false;
    }

    if(!emailIsvalid(email)){
      authTextfieldErrorCubit.showSignUpEmailError("Invalid email");
      return false;
    }

    if(!passwordIsValid(pswd)){
      authTextfieldErrorCubit.showSignUpPswdError("Invalid password. Atleast 4 characters");
      return false;
    }

    if(pswd != confPswd){
      authTextfieldErrorCubit.showSignUpConfPswdError("Passwords donot match");
      return false;
    }

    return true;
  
}

bool loginFieldsAreValid({@required BuildContext context, @required String email, @required String password}){
  final authTextfieldErrorCubit = context.bloc<AuthTextfieldErrorCubit>();

    if(!emailIsvalid(email)){
      authTextfieldErrorCubit.showSignUpEmailError("Invalid email");
      return false;
    }

   if(!passwordIsValid(password)){
      authTextfieldErrorCubit.showSignUpPswdError("Invalid password. Atleast 4 characters");
      return false;
   }

   return true;
}

showCustomSnackBar({BuildContext context, String message}){
  final snackbar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: "Ok", 
        onPressed: (){
          Scaffold.of(context).hideCurrentSnackBar();
        }
      ),
    );
  Scaffold.of(context).showSnackBar(snackbar);
}


