import 'package:camel_up/cubit/enter_role_cubit.dart';
import 'package:camel_up/cubit/team_selection_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/shared_widgets/circular_button.dart';
import 'package:camel_up/shared_widgets/search_result.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectedTeamMember extends StatefulWidget{
  final Profile profile;

  SelectedTeamMember({@required this.profile});

  @override
  _SelectedTeamMemberState createState() => _SelectedTeamMemberState();
}

class _SelectedTeamMemberState extends State<SelectedTeamMember> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 4.0),
          child: Text("Tell the role",
            style: TextStyle(
              color: AppColors.lightGrey,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        SearchResult(
          onTap: null, 
          profile: widget.profile
        ),

        Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: AppColors.lightGrey
          ),
          margin: const EdgeInsets.fromLTRB(40, 5.0, 40, 15.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter role", 
            ),
            onChanged: (string){
              if(string.trim().length > 0){
                context.bloc<EnterRoleCubit>().startEnterRole();
              }else{
                context.bloc<EnterRoleCubit>().resetEnterRole();
              }
            },
          ),
        ),

        BlocBuilder<EnterRoleCubit, EnterRoleState>(
          builder: (context, state) {

            if(state is EnterRoleInitial){
              return CircularButton(
                size: 65, 
                borderColor: AppColors.lightGrey, 
                icon: Icons.done, 
                iconSize: 48, 
                iconColor: AppColors.lightGrey,
                onTap: (){
                  Fluttertoast.showToast(msg: "Please enter a role");
                }
              );
            }else {
              return CircularButton(
                size: 65, 
                borderColor: AppColors.green, 
                icon: Icons.done, 
                iconSize: 48, 
                iconColor: AppColors.green,
                onTap: (){
                  final role = _controller.text.trim();
                  PrefManager.saveTeamMember(
                    email: widget.profile.email, 
                    role: role
                  );
                  context.bloc<EnterRoleCubit>().resetEnterRole();
                  context.bloc<TeamSelectionCubit>().goToTeamSelection();
                  showCustomToast("Role selected successfully");
                }
              );
            }

            
          }
        )

      ],
    );
  }
}