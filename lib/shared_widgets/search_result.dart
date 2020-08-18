import 'package:camel_up/models/profile.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget{
  final VoidCallback onTap;
  final Profile profile;

  SearchResult({@required this.onTap, @required this.profile});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: onTap,
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
          child: Row(
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
                    child: Text(profile.about ?? "N/A",
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
          ),
        ),
      ),
    );
  }

}