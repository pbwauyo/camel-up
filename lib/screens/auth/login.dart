import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/auth_status_cubit.dart';
import 'package:camel_up/cubit/auth_textfield_error_cubit.dart';
import 'package:camel_up/shared_widgets/auth_textfield.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailTextController = TextEditingController();
  final pswdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is AuthError){
                    Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: AppColors.yellow
                    );
                }
              },
              child: BlocListener<AuthStatusCubit, AuthStatusState>(
                listener: (context, state){
                  if(state is AuthLoggedInSuccess){
                    Fluttertoast.showToast(
                      msg: "Login Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: AppColors.yellow    
                    );
                  }
                } ,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0, top: 30.0),
                    child: Text(
                      "LOGIN NOW",
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
                      margin: const EdgeInsets.only(bottom: 75.0),
                      child: AuthTextField(
                        hint: "Email", 
                        textController: emailTextController,
                        error: state is LoginEmailTextfieldError ? state.message : null,
                      ),
                    );
                  }
                ),

                BlocBuilder<AuthTextfieldErrorCubit, AuthTextfieldErrorState>(
                  builder: (context, state) {
                    return Container(
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: AuthTextField(
                          hint: "Password", 
                          textController: pswdTextController,
                          error: state is LoginPswdTextfieldError ? state.message : null,
                        )
                    );
                  }
                ),

                BlocBuilder<AuthStatusCubit, AuthStatusState>(
                  builder: (context, state) {     
                    return Visibility(
                        visible: state is AuthLoading,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: CircularProgressIndicator()
                      );
                  },
                )
              ],
            ),
            Center(
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {},
                child: Container(
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: AppColors.darkGreyTextColor, fontSize: 20),
                  ),
                ),
              ),
            ),
            Center(
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return InkWell(
                    splashColor: Colors.black38,
                    onTap: () {
                      final authCubit = context.bloc<AuthCubit>();
                      final email = emailTextController.text.trim();
                      final pswd = pswdTextController.text.trim();

                      final fieldsAreValid = loginFieldsAreValid(
                        context: context,
                        email: email, password: pswd);

                      if(fieldsAreValid){
                        authCubit.loginUser(context, email, pswd);
                      }else{
                        return;
                      }
                      
                    },
                    child: Container(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: AppColors.lightGrey, fontSize: 25),
                      ),
                    ),
                  );
                }
              ),
            ),
            Center(
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {
                  final authCubit = context.bloc<AuthCubit>();
                  authCubit.goToSignup();
                },
                child: Container(
                  child: RichText(
                      text: TextSpan(style: TextStyle(fontSize: 20), children: [
                    TextSpan(
                        text: "Don’t have an acount ? ",
                        style: TextStyle(
                          color: AppColors.darkGreyTextColor,
                        )),
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.yellow,
                        ))
                  ])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pswdTextController.dispose();
    emailTextController.dispose();
  }
}
