import 'package:camel_up/cubit/post_upload_cubit.dart';
import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/cubit/selected_radio_button_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/done_button.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/shared_widgets/search_result.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/custom_radio_button.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPrivacyScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: BlocListener<PostUploadCubit, PostUploadState>(
            listener: (context, state){
              if (state is PostUploadError){
                showCustomToast("failed to save post: ${state.message}");
              }else if(state is PostUploadDone){
                showCustomToast("Post saved successfully");
              }
            },
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text("Select who can see your post",
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
                                Navigations.goToPostPrivacyListDialog(context);
                              }
                            ),
                          ),
                        )
                      ],
                    );
                  }
                ),

                Expanded(
                  // height: 300,
                  child: BlocBuilder<PrivacyMembersCubit, PrivacyMembersState>(
                    builder: (context, state){
                      if(state is PrivacyMembersInitial){
                        return Container();
                      }else{
                        return StreamBuilder<List<Profile>>(
                          stream: context.bloc<PrivacyMembersCubit>().usersStream,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              final results = snapshot.data;
                              if(results.length > 0){
                                return ListView.builder(
                                  itemCount: results.length,
                                  itemBuilder: (context, index){
                                    return SearchResult(
                                      onTap: (){}, 
                                      profile: results[index]
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      PrevButton(callback: (){
                        Navigations.popScreen(context);
                      }),

                      BlocBuilder<PostUploadCubit, PostUploadState>(
                        builder: (context, state) {

                          return DoneButton(
                            enabled: !(state is PostUploadInProgress),
                            state: state,
                            text: "Finished!", 
                            color: AppColors.yellow,
                            onTap: () async{
                              
                              final radioButtonState = context.bloc<SelectedRadioButtonCubit>().state;
                              final privacy = radioButtonState.selectedButton;

                              if(radioButtonState is SelectedRadioButtonSelection){
                                final privacyList = (await PrefManager.getPostPrivacyList()).cast<String>();
                                await PrefManager.savePostPrivacyDetails(
                                  privacy: privacy,
                                  privacyList: privacyList
                                );
                              }else{
                                await PrefManager.savePostPrivacyDetails(
                                  privacy: privacy,
                                );
                              }
                              context.bloc<PostUploadCubit>().uploadPost(context);
                              
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
      ),
    );
  }
}