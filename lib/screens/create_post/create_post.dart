import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/screens/create_post/post_details.dart';
import 'package:camel_up/screens/the_team/the_team.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CreatePost extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text("Create post",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: AppColors.yellow
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text("Resources, your thought, feelings and everything that could be useful for all Cammellers!",
            style: TextStyle(
              fontSize: 20,
              color: AppColors.lightGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(AssetNames.WOMAN_SVG,
                  width: 150,
                  height: 200,
                ),
              ),

              Container(
                child: SvgPicture.asset(AssetNames.BOARD_SVG,
                  width: 100,
                  height: 150,
                ),
              )
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PrevButton(callback: (){
              
            }), 
            NextButton(
              text: "next step", 
              callback: () async{
                final email = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;
                Navigations.slideFromRight(
                  context: context, 
                  newScreen: PostDetails()
                );
              }
            )
          ],
        )
      ],
    );
  }
}