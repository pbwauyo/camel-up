import 'package:camel_up/cubit/auth_textfield_error_cubit.dart';
import 'package:camel_up/models/idea.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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

ImageProvider showImage(String image){
  if(image != null && image.isNotEmpty){
    return NetworkImage(image);
  }
  return AssetImage(AssetNames.APP_LOGO_PNG);
}

bool theresAMatch(Profile profile, String keyword){

  return ((profile.lastName.toLowerCase().contains(keyword.toLowerCase()) 
  || profile.firstName.toLowerCase().contains(keyword.toLowerCase())));
}

showCustomToast(String message){
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColors.yellow,
    textColor: AppColors.darkGreyTextColor
  );
}

Future<PickedFile> chooseImageFromGallery() async{
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  return pickedFile;
}




