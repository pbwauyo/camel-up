import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/auth_status_cubit.dart';
import 'package:camel_up/cubit/auth_textfield_error_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/shared_widgets/auth_textfield.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confPasswordController = TextEditingController();

  final fNameController = TextEditingController();

  final lNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is AuthSignUpError){
                  print("Signup lister");
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: AppColors.yellow
                    );
                }
              },
              child: BlocListener<AuthStatusCubit, AuthStatusState>(
                listener: (context, state) {
                  if(state is AuthSignUpSuccess){
                    Fluttertoast.showToast(
                      msg: "Account created successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: AppColors.yellow
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(     
                builder: (context, state) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: AuthTextField(
                      hint: "Firstname", 
                      textController: fNameController, 
                      error: state is SignUpFNameTextfieldError ? state.message : null,
                    ),
                  );
                }
              ),
              BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(
                builder: (context, state) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: AuthTextField(
                      hint: "Lastname", 
                      textController: lNameController,
                      error: state is SignUpLNameTextfieldError ? state.message : null,
                    ),
                  );
                }
              ),
              BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(
                builder: (context, state) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: AuthTextField(
                      hint: "Email", 
                      textController: emailController,
                      error: state is SignUpEmailTextfieldError ? state.message : null,
                    ),
                  );
                }
              ),
              BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(
                builder: (context, state) {
                  return Container(
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: AuthTextField(
                        hint: "Password", 
                        textController: passwordController,
                        error: state is SignUpPswdTextfieldError ? state.message : null,
                     )
                  );
                }
              ),
              BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(
                builder: (context, state) {
                  return Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 75.0),
                    child: AuthTextField(
                      hint: "Confirm Password", 
                      textController: confPasswordController,
                      error: state is SignUpConfPswdTextfieldError ? state.message : null,
                    ),
                  );
                }
              ),

              BlocBuilder<AuthStatusCubit, AuthStatusState>(
                builder: (context, state) {
                  return Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: state is AuthLoading,
                    child: CircularProgressIndicator()
                  );
                },
              )    
            ],
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {
                  final authCubit = context.bloc<AuthCubit>();
                  
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final confPassword = confPasswordController.text.trim();
                  final fName = fNameController.text.trim();
                  final lName = lNameController.text.trim();

                  final fieldsAreValid = signUpFieldsAreValid(
                    context: context, 
                    fName: fName, 
                    lName: lName, 
                    email: email, 
                    pswd: password, 
                    confPswd: confPassword);

                  if(fieldsAreValid){
                    print("fields are valid");
                    final profile = Profile(
                      email: email, 
                      password: password, 
                      firstName: fName, 
                      lastName: lName, 
                      profileImage: ""
                    );
                    authCubit.signUpUser(context, profile);
                  }else {
                    print("fields are invalid");
                    return;
                  }
                  
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: AppColors.lightGrey, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {
                  final authCubit = context.bloc<AuthCubit>();
                  authCubit.goToLogin();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: RichText(
                      text: TextSpan(style: 
                      TextStyle(fontSize: 20), 
                      children: [
                        TextSpan(
                            text: "Already have an acount ?",
                            style: TextStyle(
                              color: AppColors.darkGreyTextColor,
                        )),
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: AppColors.yellow,
                        ))
                  ])),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    confPasswordController.dispose();
  }
}
