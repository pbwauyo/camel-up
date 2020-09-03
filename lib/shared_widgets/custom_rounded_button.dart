import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget{
  final String text;
  final bool unRoundedTopRight;
  final VoidCallback onTap;
  final Color color;

  CustomRoundedButton({@required this.text, @required this.onTap, 
      @required this.unRoundedTopRight, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4.0,
      borderRadius: BorderRadius.only(
        topRight: unRoundedTopRight ? Radius.circular(0.0) : Radius.circular(45.0),
        bottomRight: Radius.circular(45.0),
        bottomLeft: Radius.circular(45.0),
        topLeft: unRoundedTopRight ? Radius.circular(45.0) : Radius.circular(0.0),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black38,
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: color ?? AppColors.lightGrey,
            borderRadius: BorderRadius.only(
                topRight: unRoundedTopRight ? Radius.circular(0.0) : Radius.circular(45.0),
                bottomRight: Radius.circular(45.0),
                bottomLeft: Radius.circular(45.0),
                topLeft: unRoundedTopRight ? Radius.circular(45.0) : Radius.circular(0.0),
              )
          ),
          child: Text(text,
            style: TextStyle(
              color: AppColors.darkBackground,
              fontSize: 25
            ),
          ),
        ),
      ),
    ); 
  }
}