import 'package:camel_up/models/idea.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card.dart';
import 'package:camel_up/screens/idea_list/idea_list.dart';
import 'package:camel_up/shared_widgets/beautiful_divider.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/custom_rounded_button.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/shared_widgets/underlined_text.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  final String email;

  ProfilePage({@required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepo _userRepo = UserRepo();
  final IdeaRepo _ideaRepo = IdeaRepo();
  Future<Profile> _profileFuture;
  Future<Idea> _ideaFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _userRepo.getUserProfile(widget.email);
    _ideaFuture = _ideaRepo.getFirstUserIdea(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: FutureBuilder<Profile>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final _profile = snapshot.data;
              return ListView(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetNames.COVER_PIC),
                            fit: BoxFit.fill
                          )
                        ),
                      ),

                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: -45,
                        child: Center(
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              image: DecorationImage(
                                image: showImage(_profile.profileImage),
                                fit: BoxFit.fill
                              )
                            ),
                          ),
                        )
                      )
                    ],
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: Text("${_profile.firstName} ${_profile.lastName}",
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text("Move Immediately",
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text("${_profile.about}",
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ),

                  BeautifulDivider(
                    marginHorizontal: 10.0,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRoundedButton(
                          text: "Disconnect", 
                          onTap: (){}, 
                          unRoundedTopRight: false
                        ),

                        CustomRoundedButton(
                          text: "Other", 
                          onTap: (){}, 
                          unRoundedTopRight: true
                        ),
                      ],
                    ),
                  ) ,

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: UnderlinedText(
                        text: "Ideas Posted", 
                        onTap: (){
                          Navigations.slideFromRight(
                            context: context, 
                            newScreen: IdeaList(email: _profile.email,)
                          );
                        }
                      ),
                    ),
                  ),

                  FutureBuilder<Idea>(
                    future: _ideaFuture,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final idea = snapshot.data;
                        if(idea.id == null){
                          return Center(child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 5),
                            child: EmptyResultsText(message: "No Ideas to display",))
                          );
                        }
                        return Center(child: IdeaCard(idea: idea));
                      }
                      else if(snapshot.hasError){
                        return Center(child: ErrorText(error: snapshot.error));
                      }
                      return Center(child: CustomProgressIndicator());
                    },
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: UnderlinedText(
                        text: "Resources Posted", 
                        onTap: (){
                          
                        }
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: UnderlinedText(
                        text: "Other Activities", 
                        onTap: (){
                          
                        }
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text("No other activities available",
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                  
                ],
              );
            }else if(snapshot.hasError){
              return ErrorText(error: snapshot.error);
            }
            return CustomProgressIndicator();
          }
        ),
      ),
    );
  }
}