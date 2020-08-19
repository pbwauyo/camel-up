import 'package:camel_up/screens/the_audience/the_audience.dart';
import 'package:camel_up/screens/the_idea/widgets/insert_widget.dart';
import 'package:camel_up/screens/the_idea/widgets/team_members_row.dart';
import 'package:camel_up/screens/the_idea/widgets/the_idea_header.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TheIdea extends StatefulWidget{
  @override
  State<TheIdea> createState() {
    return _TheIdeaState();
  }
}

class _TheIdeaState extends State<TheIdea>{
  final keywordController = TextEditingController();
  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: TheIdeaHeader()
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text("Tell about your idea. Add materials and fill in each section",
              style: TextStyle(
                color: AppColors.lightGrey,
                fontSize: 20
              ),
            ),
          ),

          TeamMembersRow(),

          InsertWidget(
            controller: keywordController, 
            text: "Insert keyword for idea", 
            icon: Icons.add_circle_outline,
            showInfoIcon: true,
            onTap: (){

            },
          ),

          InsertWidget(
            controller: titleController,
            text: "Insert Title", 
            onTap: (){

            }, 
            icon: Icons.add
          ),

          InsertWidget(
            controller: textController,
            text: "Insert Text", 
            onTap: (){

            }, 
            icon: Icons.text_fields
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: InsertWidget(
              text: "Insert Audio", 
              onTap: (){

              }, 
              icon: Icons.volume_up,
              isMedia: true,
             ),
          ),

           InsertWidget(
            text: "Insert Video", 
            onTap: (){

            }, 
            icon: Icons.videocam,
            isMedia: true,
           ),

           Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrevButton(callback: (){
                  Navigations.popScreen(context);
                }),

                NextButton(
                  text: "next step", 
                  callback: (){
                    final keywords = keywordController.text.trim().split(",");
                    final title = titleController.text.trim();
                    final text = textController.text.trim();

                    if(title.isEmpty){
                      showCustomToast("Please fill in the title");
                      return;
                    }
                    if(text.isEmpty){
                      showCustomToast("Please fill in text");
                      return;
                    }

                    PrefManager.saveIdeaDetails(
                      keywords: keywords, 
                      title: title, 
                      text: text
                    );

                    Navigations.slideFromRight(
                      context: context, 
                      newScreen: TheAudience()
                    );
                  }
                )
              ],
            ),
          )
          
        ],
      ),
    );
  }
}