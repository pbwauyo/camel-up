import 'package:camel_up/cubit/idea_upload_cubit.dart';
import 'package:camel_up/cubit/need_teammates_cubit.dart';
import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/cubit/selected_radio_button_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/screens/chat_screen/chat_screen.dart';
import 'package:camel_up/screens/privacy_list_dialog/privacy_list_dialog.dart';
import 'package:camel_up/screens/the_audience/wigets/the_audience_header.dart';
import 'package:camel_up/screens/the_idea/widgets/insert_widget.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/done_button.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/shared_widgets/privacy_widget.dart';
import 'package:camel_up/shared_widgets/search_result.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/custom_radio_button.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TheAudience extends StatefulWidget{
  @override
  _TheAudienceState createState() => _TheAudienceState();
}

class _TheAudienceState extends State<TheAudience> {
  final teammateKeywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: BlocListener<IdeaUploadCubit, IdeaUploadState>(
        listener: (context, state){
          if (state is IdeaUploadError){
            showCustomToast("failed to save idea: ${state.message}");
          }else if(state is IdeaUploadDone){
            showCustomToast("Idea saved successfully");
          }
        },
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: TheAudienceHeader()
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Tick the box if you are looking for teammates",
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 20
                ),
              ),
            ),

            Center(
              child: BlocBuilder<NeedTeammatesCubit, NeedTeammatesState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                        children: [

                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.black38,
                              onTap: (){
                                if(state is NeedTeammatesTrue){
                                  context.bloc<NeedTeammatesCubit>().dontNeedTeammates();
                                }else{
                                  context.bloc<NeedTeammatesCubit>().needTeammates();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(right: 10, left: 20),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: AppColors.yellow, width: 3)
                                ),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: state is NeedTeammatesTrue ? 1 : 0,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: AppColors.yellow,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text("TeamMates",
                              style: TextStyle(
                                color: AppColors.lightGrey,
                                fontSize: 25
                              ),
                            ),  
                          ),
                        ],
                      ),

                       Container(
                         margin: const EdgeInsets.only(left: 5),
                         child: InsertWidget(
                          isEnabled: state is NeedTeammatesTrue,
                          controller: teammateKeywordController, 
                          text: "Insert keyword for idea", 
                          icon: Icons.add_circle_outline,
                          showInfoIcon: true,
                          onTap: (){

                          },
                      ),
                       ),
                    ],
                  );
                }
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Select who can see your idea",
                style: TextStyle(
                  color: AppColors.lightGrey,
                  fontSize: 20
                ),
              ),
            ),

            BlocBuilder<SelectedRadioButtonCubit, SelectedRadioButtonState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Center(
                        child: CustomRadioButton(
                          isSelected: state is SelectedRadioButtonEveryone,
                          text: "Everyone", 
                          onTap: (){
                            context.bloc<SelectedRadioButtonCubit>().everyoneSelected();
                          }
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Center(
                        child: CustomRadioButton(
                          isSelected: state is SelectedRadioButtonNoOne,
                          text: "No one for now", 
                          onTap: (){
                            context.bloc<SelectedRadioButtonCubit>().noOneSelected();
                          }
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Center(
                        child: CustomRadioButton(
                          isSelected: state is SelectedRadioButtonSelection,
                          text: "Selection", 
                          onTap: (){
                            context.bloc<SelectedRadioButtonCubit>().selection();
                            Navigations.goToPrivacyListDialog(context);
                          }
                        ),
                      ),
                    )
                  ],
                );
              }
            ),

            Container(
              height: 300,
              child: BlocBuilder<PrivacyMembersCubit, PrivacyMembersState>(
                builder: (context, state){
                  if(state is PrivacyMembersInitial){
                    return Container();
                  }else{
                    return StreamBuilder<List<String>>(
                      stream: context.bloc<PrivacyMembersCubit>().usersStream,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          final results = snapshot.data;
                          if(results.length > 0){
                            return ListView.builder(
                              itemCount: results.length,
                              itemBuilder: (context, index){
                                return PrivacyWidget(
                                  onTap: (){
                                    Navigations.slideFromRight(
                                      context: context, 
                                      newScreen: ChatScreen(receiverEmail: results[index])
                                    );
                                  }, 
                                  email: results[index]
                                );
                              }
                            );
                          }else{
                            return EmptyResultsText();
                          }
                        }
                        else if(snapshot.hasError){
                          return Center(
                            child: ErrorText(error: "${snapshot.error}"),
                          );
                        }

                        return CustomProgressIndicator(
                          color: AppColors.yellow
                        );
                      }
                    );
                  }
                }
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  PrevButton(callback: (){
                    Navigations.popScreen(context);
                  }),

                  BlocBuilder<IdeaUploadCubit, IdeaUploadState>(
                    builder: (context, state) {

                      return DoneButton(
                        enabled: !(state is IdeaUploadInProgress),
                        state: state,
                        text: "Finished!", 
                        color: AppColors.yellow,
                        onTap: () async{
                          final keywords = teammateKeywordController.text.trim().split(",");

                          final radioButtonState = context.bloc<SelectedRadioButtonCubit>().state;
                          final privacy = radioButtonState.selectedButton;

                          if(radioButtonState is SelectedRadioButtonSelection){
                            final privacyList = (await PrefManager.getPrivacyList()).cast<String>();
                            await PrefManager.saveAudienceDetails(
                              privacy: privacy,
                              teamKeywords: keywords,
                              privacyList: privacyList
                            );
                          }else{
                            await PrefManager.saveAudienceDetails(
                              privacy: privacy,
                              teamKeywords: keywords
                            );
                          }
                          context.bloc<IdeaUploadCubit>().uploadIdea(context);
                          
                        }
                      );
                    }
                  )

                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}