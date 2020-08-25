import 'package:camel_up/cubit/selected_members_count_cubit.dart';
import 'package:camel_up/cubit/selected_members_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/the_idea/widgets/team_member_image.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMembersRow extends StatefulWidget{
  
  TeamMembersRow();

  @override
  _TeamMembersRowState createState() => _TeamMembersRowState();
}

class _TeamMembersRowState extends State<TeamMembersRow> {
  final double size = 50;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(40)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: context.bloc<SelectedMembersCubit>().selectedMembersStream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final results = snapshot.data;
                 if(results.length > 0){
                   return Container(
                      height: 90,
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length > 3 ? 3 : results.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return TeamMemberImage(
                          email: results[index]["email"]
                        );
                      }
                    ),
                  );
                 }else{
                   return Container();
                 }
              }else if(snapshot.hasError){
                return Center(
                  child: ErrorText(
                    error: snapshot.error
                  ),
                );
              }else{
                return Center(
                  child: CustomProgressIndicator(
                    color: AppColors.yellow
                  ),
                );
              }
             
            }
          ),

          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black38,
                  onTap: (){
                    Navigations.goToSearchDialog(context);
                  },
                  child: Container(
                    child: Icon(Icons.add,
                      size: 50,
                      color: AppColors.darkBackground, 
                    ),
                  ),
                ),
             ),

              BlocBuilder<SelectedMembersCountCubit, SelectedMembersCountState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkBackground, width: 4),
                      borderRadius: BorderRadius.circular(size/2)
                    ),
                    child: Center(
                      child: Text(state is SelectedMembersCountDone ? state.count.toString() : "0",
                        style: TextStyle(
                          color: AppColors.darkBackground,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  );
                }
              ),
            ],
          )
        ],
      ),
    );
  }
}