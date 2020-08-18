import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget{
  final String text;
  final VoidCallback callback;

  NextButton({@required this.text, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: callback,
        splashColor: Colors.black38,
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(45.0),
                bottomLeft: Radius.circular(45.0),
                topLeft: Radius.circular(45.0),
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