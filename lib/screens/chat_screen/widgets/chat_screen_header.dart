import 'package:camel_up/cubit/auth_cubit.dart';
import 'package:camel_up/models/profile.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenHeader extends StatelessWidget {
  final UserRepo _userRepo = UserRepo();

  ChatScreenHeader();

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = (context.bloc<AuthCubit>().state as AuthLoggedIn).email;

    return StreamBuilder<QuerySnapshot>(
      stream: _userRepo.getUserAsStream(currentUserEmail),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          
          final doc = snapshot.data.docs[0];
          final profile = Profile.fromMap(doc.data());
          final double imageSize = 130;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(imageSize/2),
                  image: DecorationImage(
                    image: showImage(profile.profileImage),
                    fit: BoxFit.cover,
                  )
                ),
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text("${profile.firstName} ${profile.lastName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),

                  Container(
                    child: Text(profile.onlineStatus,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }
        else if(snapshot.hasError){
          return Center(child: ErrorText(error: snapshot.error));
        }
        return Center(child: CustomProgressIndicator());
      }
    );
  }
}