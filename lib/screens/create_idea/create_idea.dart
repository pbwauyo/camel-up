import 'package:camel_up/screens/the_team/the_team.dart';
import 'package:camel_up/shared_widgets/idea_steps_widget.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class CreateIdea extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text("Create an idea",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: AppColors.yellow
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text("this section let's you create a post to share your idea and receive feedbacks",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: IdeaStepsWidget(title: "The team", number: "1")
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: IdeaStepsWidget(title: "The idea", number: "2")
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: IdeaStepsWidget(title: "Audience", number: "3")
              )
              
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PrevButton(callback: (){
                
              }), 
              NextButton(
                text: "next step", 
                callback: (){
                  Navigations.slideFromRight(context: context, newScreen: TheTeam());
                }
              )
            ],
          )

        ],
      ),
    );
  }
}