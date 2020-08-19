import 'package:camel_up/cubit/need_teammates_cubit.dart';
import 'package:camel_up/cubit/selected_radio_button_cubit.dart';
import 'package:camel_up/screens/the_audience/wigets/the_audience_header.dart';
import 'package:camel_up/screens/the_idea/widgets/insert_widget.dart';
import 'package:camel_up/shared_widgets/next_button.dart';
import 'package:camel_up/shared_widgets/prev_button.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/custom_radio_button.dart';
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
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: TheAudienceHeader()
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text("Tick the box if you arelooking for teammates",
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
                        }
                      ),
                    ),
                  )
                ],
              );
            }
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
                  text: "Finished!", 
                  color: AppColors.yellow,
                  callback: (){
                    final keywords = teammateKeywordController.text.trim().split(",");

                    final radioButtonState = context.bloc<SelectedRadioButtonCubit>().state;
                    final privacy = radioButtonState.selectedButton;
                    if(radioButtonState is SelectedRadioButtonSelection){
                      //todo: add selected members to list
                    }else{
                      PrefManager.saveAudienceDetails(
                        privacy: privacy,
                        teamKeywords: keywords
                      );
                    }

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