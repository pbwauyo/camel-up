import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: (){
            final authCubit = context.bloc<AuthCubit>();
            authCubit.logoutUser();
          },
          child: Text("HELLO WORLD"),
          ),
      ),
    );
  }
}