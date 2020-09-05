import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/cubit/bottom_bar_button_cubit.dart';
import 'package:camel_up/cubit/nav_menu_item_cubit.dart';
import 'package:camel_up/models/idea.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/screens/chat_screen/chat_screen.dart';
import 'package:camel_up/screens/create_idea/create_idea.dart';
import 'package:camel_up/screens/create_post/create_post.dart';
import 'package:camel_up/screens/donate/donate.dart';
import 'package:camel_up/screens/idea_list/idea_list.dart';
import 'package:camel_up/screens/main_chat_screen/main_chat_screen.dart';
import 'package:camel_up/screens/profile_page/profile_page.dart';
import 'package:camel_up/screens/the_idea/the_idea.dart';
import 'package:camel_up/shared_widgets/custom_bottom_bar.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {

    final email = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;

    return Scaffold(
      appBar: AppBar(
        title: Text("Camel Up"),
        backgroundColor: AppColors.primaryDark,
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.navDrawerHeader,
              ),
              margin: EdgeInsets.zero,
              child: StreamBuilder<QuerySnapshot>(
                stream: _userRepo.getUserAsStream(email),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final docs = snapshot.data.documents;
                    if(docs.length <= 0){
                      return EmptyResultsText(message: "No matching profile",);
                    }
                    final profile = Profile.fromMap(docs[0].data);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: showImage(profile.profileImage),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Text("${profile.firstName} ${profile.lastName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(profile.email,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    return ErrorText(error: snapshot.error);
                  }
                  return CustomProgressIndicator();
                }
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.navDrawerBody,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<NavMenuItemCubit, NavMenuItemState>(
                      builder: (context, state) {
                        final navMenuCubit = context.bloc<NavMenuItemCubit>();

                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightProfile();
                                  Navigations.popScreen(context);
                                  Navigations.slideFromRight(
                                    context: context, 
                                    newScreen: ProfilePage(email: email, isCurrentUser: true,)
                                  );
                                },
                                child: Container(
                                  color: state is NavMenuItemProfile ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: SvgPicture.asset(AssetNames.PROFILE_SVG,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.yellow
                                        ),
                                      ),
                                      Container(
                                        child: Text("Profile",
                                          style: TextStyle(
                                            color: state is NavMenuItemProfile ? AppColors.yellow : Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightChats();
                                  Navigations.popScreen(context);
                                  Navigations.slideFromRight(
                                    context: context, 
                                    newScreen: MainChatScreen()
                                  );
                                },
                                child: Container(
                                  color: state is NavMenuItemChats ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: SvgPicture.asset(AssetNames.CHATS_SVG,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.yellow
                                        ),
                                      ),
                                      Container(
                                        child: Text("Chats",
                                          style: TextStyle(
                                            color: state is NavMenuItemChats ? AppColors.yellow : Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightDonate();
                                  Navigations.popScreen(context);
                                  Navigations.slideFromRight(
                                    context: context, 
                                    newScreen: DonatePage()
                                  );
                                },
                                child: Container(
                                  color: state is NavMenuItemDonate ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: SvgPicture.asset(AssetNames.DONATE_SVG,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.yellow
                                        ),
                                      ),
                                      Container(
                                        child: Text("Donate",
                                          style: TextStyle(
                                            color: state is NavMenuItemDonate ? AppColors.yellow: Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightAbout();
                                  Navigations.popScreen(context);
                                  // Navigations.slideFromRight(
                                  //   context: context, 
                                  //   newScreen: DonatePage()
                                  // );
                                },
                                child: Container(
                                  color: state is NavMenuItemAbout ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: SvgPicture.asset(AssetNames.ABOUT_SVG,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.yellow
                                        ),
                                      ),
                                      Container(
                                        child: Text("About",
                                          style: TextStyle(
                                            color: state is NavMenuItemAbout ? AppColors.yellow : Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightHelp();
                                  Navigations.popScreen(context);
                                  // Navigations.slideFromRight(
                                  //   context: context, 
                                  //   newScreen: DonatePage()
                                  // );
                                },
                                child: Container(
                                  color: state is NavMenuItemHelp ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: SvgPicture.asset(AssetNames.HELP_SVG,
                                          width: 50,
                                          height: 50,
                                          color: AppColors.yellow
                                        ),
                                      ),
                                      Container(
                                        child: Text("Help",
                                          style: TextStyle(
                                            color: state is NavMenuItemHelp ? AppColors.yellow : Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  navMenuCubit.highlightLogout();
                                  Navigations.popScreen(context);
                                  context.bloc<AuthCubit>().logoutUser();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                                  color: state is NavMenuItemLogout ? AppColors.lightGrey.withOpacity(0.5) : Colors.transparent,
                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        child: Icon(Icons.power_settings_new,
                                          size: 48,
                                          color: AppColors.yellow,
                                        ),
                                      ),
                                      Container(
                                        child: Text("Logout",
                                          style: TextStyle(
                                            color: state is NavMenuItemLogout ? AppColors.yellow : Colors.white,
                                            fontSize: 20
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text("Verion 1.0.0",
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ), 
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
      backgroundColor: AppColors.darkBackground,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<BottomBarButtonCubit, BottomBarButtonState>(
              builder: (context, state){
                if (state is BottomBarButtonCreateIdea){
                  return CreateIdea();
                }
                else if(state is BottomBarButtonCreatePost){
                  return CreatePost();
                }
                return IdeaList(email: email);
              }
            )
          ),
          CustomBottomBar()
        ],
      ),
    );
  }
}