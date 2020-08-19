import 'package:camel_up/cubit/selected_members_cubit.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/the_idea/the_idea.dart';
import 'package:camel_up/shared_widgets/add_button.dart';
import 'package:camel_up/shared_widgets/circular_button.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/shared_widgets/idea_steps_widget_advanced.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/shared_widgets/search_dialog.dart';
import 'package:camel_up/shared_widgets/selected_member.dart';
import 'package:camel_up/shared_widgets/yellow_dot.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TheTeam extends StatelessWidget{
  final String currentUserEmail; 
 
  TheTeam({@required this.currentUserEmail});
  
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
              shrinkWrap: true,
              children: [
                SelectedMember(
                  email: currentUserEmail,
                  role: "Chief Executive Officer",
                ),
                BlocBuilder<SelectedMembersCubit, SelectedMembersState>(
                  builder: (context, state) {

                    if(state is SelectedMembersInitial){
                      return Container();
                    }
                    //else show list of team members
                    return Container(
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                        stream: context.bloc<SelectedMembersCubit>().selectedMembersStream,
                        builder: (context, snapshot) {

                          final results = snapshot.data;

                          if (snapshot.hasData) {

                            if(results.length <= 0){
                              return Container();
                            }else{
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: results.length,
                                itemBuilder: (context, index){
                                  final email = results[index]["email"];
                                  final role = results[index]["role"];
                                  return SelectedMember(
                                    email: email, 
                                    role: role
                                  );
                                },
                              );
                            }
                            
                          }else if(snapshot.hasError){
                            return Center(
                              child: ErrorText(error: snapshot.error,)
                            );
                          }else {
                            return Center(
                              child: CustomProgressIndicator(color: AppColors.yellow)
                            );
                          }
                          
                        }
                      ),
                    );
                  }
                ),
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
                Navigations.goToSearchDialog(context);
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
                  callback: (){
                    Navigations.slideFromRight(
                      context: context, 
                      newScreen: TheIdea()
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