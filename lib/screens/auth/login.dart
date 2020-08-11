import 'package:camel_up/shared_widgets/auth_textfield.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
              child: Text(
                "LOGIN NOW",
                style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 75.0),
                child: AuthTextField(hint: "Email"),
              ),
              Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: AuthTextField(hint: "Password")),
            ],
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Forgot password?",
                style:
                    TextStyle(color: AppColors.darkGreyTextColor, fontSize: 20),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "LOGIN",
                style: TextStyle(color: AppColors.lightGrey, fontSize: 25),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
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
        ],
      ),
    );
  }
}
