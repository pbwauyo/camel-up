import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class TeamMemberImage extends StatefulWidget{
  final String email;

  TeamMemberImage({@required this.email});
  @override
  _TeamMemberImageState createState() => _TeamMemberImageState();
}

class _TeamMemberImageState extends State<TeamMemberImage> {

  Future<Profile> _getUserProfile;
  final _userRepo = UserRepo();
  final double size = 60;

  @override
  void initState() {
    super.initState();
    _getUserProfile = _userRepo.getUserProfile(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: _getUserProfile,
      builder: (context, snapshot){
        if(snapshot.hasData){
          final profile = snapshot.data;
          return Center(
            child: Container(
              margin: const EdgeInsets.only(left: 3.0),
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size/2),
                image: DecorationImage(
                  image: showImage(profile.profileImage),
                  fit: BoxFit.cover
                )
              ),
            ),
          );
        }else if(snapshot.hasError){
          return Center(
            child: ErrorText(
              error: snapshot.error
            ),
          );
        }else {
          return Center(
            child: CustomProgressIndicator(
              color: AppColors.darkGrey
            ),
          );
        }
      }
    );
  }
}