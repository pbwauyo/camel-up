import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/screens/create_idea/create_idea.dart';
import 'package:camel_up/screens/idea_list/idea_list.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IdeaList();
  }
}