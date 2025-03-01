import 'dart:ui';

import 'package:camel_up/cubit/privacy_members_cubit.dart';
import 'package:camel_up/cubit/team_results_cubit.dart';
import 'package:camel_up/cubit/team_selection_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/shared_widgets/cancel_button.dart';
import 'package:camel_up/shared_widgets/search_result.dart';
import 'package:camel_up/shared_widgets/search_textfield.dart';
import 'package:camel_up/shared_widgets/selected_team_member.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrivacyListDialog extends StatefulWidget{
  @override
  _PrivacyListDialogState createState() => _PrivacyListDialogState();
}

class _PrivacyListDialogState extends State<PrivacyListDialog> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Material(
        color: Colors.grey.shade500.withOpacity(0.5),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 400,
            child:Column(
              children: [
                Container(
                  height: 200,
                  child: BlocBuilder<TeamResultsCubit, TeamResultsState>(
                    builder: (context, state) {
                      
                      if(state is TeamResultsInitial){
                        return Center(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              color: AppColors.lightGrey,
                              child: Text("Enter keyword to search"),
                            ),
                          );
                        }
                        else if(state is TeamResultsLoaded){
                          final _stream = context.bloc<TeamResultsCubit>().usersStream;
                          
                          return StreamBuilder<List<Profile>>(
                            stream: _stream,
                            initialData: [],
                            builder: (context, snapshot) {

                              List<Profile> results = snapshot.data;
                              
                              if(snapshot.hasData){
                                if(results.length <= 0 ){
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text("No matching members"),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: results.length,
                                  itemBuilder: (context, index){
                                    final profile = results[index];
                                    return SearchResult(
                                      onTap: () async{
                                        try{
                                          await PrefManager.savePrivacyList(profile.email);
                                          showCustomToast("User added successfully");
                                        }catch(error){
                                          showCustomToast(error.message);
                                        }
                                      }, 
                                      profile: profile
                                    );
                                  }
                                );
                              }else if (snapshot.hasError){
                                return Center(
                                  child: Container(
                                    child: Text("${snapshot.error}"),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.yellow),
                                )
                              );
                          }
                        );
                        }
                        else if (state is TeamResultsError){
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(state.error),
                            ),
                          );
                        }

                        return Center(
                        child: CircularProgressIndicator(),
                        );
                              
                      }
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: SearchTextField(
                      performTeamSearch: true ,
                    )
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: CancelButton(
                        onTap: (){
                          Navigations.popScreen(context);
                          context.bloc<TeamResultsCubit>().resetState();
                          PrefManager.getPrivacyList()
                          .then((list){
                            print("List: $list");
                            if(list != null && list.length > 0){
                              context.bloc<PrivacyMembersCubit>().updatePrivacyListStream(list);
                            }
                            
                          });
                          
                        },
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}