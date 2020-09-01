import 'package:camel_up/models/idea.dart';
import 'package:camel_up/screens/idea_details/idea_details.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class CamelButton extends StatelessWidget{
  final Idea idea;

  CamelButton({@required this.idea});

  @override
  Widget build(BuildContext context) {
     return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: (){
          Navigations.slideFromRight(
            context: context, 
            newScreen: IdeaDetails(idea: idea)
          );
        },
        child: Container(
          width: 65,
          height: 65,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              topLeft: Radius.circular(0.0),
              topRight: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
            color: AppColors.darkBackground,
            image: DecorationImage(
              image: AssetImage(AssetNames.CAMEL),
              
            )
          ),
        ),
      ),
    );
  }
}