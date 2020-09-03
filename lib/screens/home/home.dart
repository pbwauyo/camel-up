import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/bottom_bar_button_cubit.dart';
import 'package:camel_up/models/idea.dart';
import 'package:camel_up/screens/create_idea/create_idea.dart';
import 'package:camel_up/screens/create_post/create_post.dart';
import 'package:camel_up/screens/idea_list/idea_list.dart';
import 'package:camel_up/screens/the_idea/the_idea.dart';
import 'package:camel_up/shared_widgets/custom_bottom_bar.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final email = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BottomBarButtonCubit, BottomBarButtonState>(
              builder: (context, state){
                if (state is BottomBarButtonCreateIdea){
                  return TheIdea();
                }
                else if(state is BottomBarButtonCreatePost){
                  return CreatePost();
                }
                return IdeaList(email: email);
              }
            )
          ),
          CustomBottomBar()
        ],
      ),
    );
  }
}