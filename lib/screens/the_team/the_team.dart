import 'package:camel_up/shared_widgets/add_button.dart';
import 'package:camel_up/shared_widgets/circular_button.dart';
import 'package:camel_up/shared_widgets/idea_steps_widget_advanced.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/shared_widgets/search_dialog.dart';
import 'package:camel_up/shared_widgets/selected_member.dart';
import 'package:camel_up/shared_widgets/yellow_dot.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class TheTeam extends StatelessWidget{
  
  TheTeam();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: IdeaStepsWidgetAdvanced(text: "The team", number: "1")
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Text("Select the people who are already part of the team with their role",
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 20
              ),
            ),
          ),

          Container(
            height: 450,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                SelectedMember(),
                SelectedMember(),
                SelectedMember(),
                SelectedMember(),
                SelectedMember(),
              ],
            ),
          ),

          Center(
            child: CircularButton(
              size: 60, 
              borderColor: AppColors.lightGrey, 
              icon: Icons.add, 
              iconSize: 55, 
              iconColor: AppColors.yellow, 
              onTap: (){
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) =>
                        SearchDialog()));
              }
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrevButton(callback: (){

                }),

                NextButton(
                  text: "next step", 
                  callback: null
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}