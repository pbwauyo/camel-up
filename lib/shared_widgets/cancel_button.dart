import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/navigations.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget{
  final BuildContext context;

  CancelButton({@required this.context});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: (){
          Navigations.popScreen(context);
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
            color: AppColors.darkBackground
          ),
          child: Icon(Icons.clear,
            color: AppColors.lightGrey,
            size: 48,
          ),
        ),
      ),
    );
  }
}