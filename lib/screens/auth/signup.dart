import 'package:camel_up/shared_widgets/auth_textfield.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
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
                "Sign Up",
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black38,
                onTap: () {},
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
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: RichText(
                      text: TextSpan(style: TextStyle(fontSize: 20), children: [
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
}
