import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectedMember extends StatefulWidget{
  final String email;
  final String role;

  SelectedMember({@required this.email, @required this.role});

  @override
  _SelectedMemberState createState() => _SelectedMemberState();
}

class _SelectedMemberState extends State<SelectedMember> {
  final double size = 60;
  Future<Profile> _getProfile;
  final _userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
    _getProfile = _userRepo.getUserProfile(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: FutureBuilder<Profile>(
        future: _getProfile,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final profile = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(widget.role ?? "",
                    style: TextStyle(
                            color: AppColors.lightGrey,
                            fontSize: 18
                          ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size/2),
                        image: DecorationImage(
                          image: AssetImage(AssetNames.APP_LOGO_PNG),
                          fit: BoxFit.fill
                        )
                      ),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("${profile.firstName} ${profile.lastName}",
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),

                        Container(
                          child: Text("Move immediately",
                          maxLines: null,
                            style: TextStyle(
                              color: AppColors.lightGrey,
                              fontSize: 20,
                              
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          }else if(snapshot.hasError){
            return Center(
              child: Container(
                child: Text("${snapshot.error}"),
              ),
            );
          }else {
            return Center(
              child: CustomProgressIndicator(
                color: AppColors.yellow
              ),
            );
          }


        }
      ),
    );
  }
}
