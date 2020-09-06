import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class PrivacyWidget extends StatefulWidget{
  final VoidCallback onTap;
  final String email;

  PrivacyWidget({@required this.onTap, @required this.email});

  @override
  _PrivacyWidgetState createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  Future<Profile> _userProfileStream;
  final _userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
    _userProfileStream = _userRepo.getUserProfile(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          margin: const EdgeInsets.only(bottom: 4, top: 4, right: 40, left: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),
            color: AppColors.lightGrey
          ),
          child: FutureBuilder<Profile>(
            future: _userProfileStream,
            builder: (context, snapshot){
              if(snapshot.hasData){
                final profile = snapshot.data;
                return Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: showImage(profile.profileImage),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text("${profile.firstName} ${profile.lastName}",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.darkBackground,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),

                        Container(
                          child: Text("Move Immediately",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.darkBackground,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: ErrorText(error: snapshot.error,),
                );
              }
              return Center(
                child: CustomProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}