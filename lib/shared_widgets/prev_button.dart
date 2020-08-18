import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrevButton extends StatelessWidget{
  final VoidCallback callback;

  PrevButton({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black38,
        onTap: callback,
        child: Transform.rotate(
          angle: -45,
          child: Container(
            width: 50,
            height: 50
            ,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(45.0),
                bottomRight: Radius.circular(45.0),
                bottomLeft: Radius.circular(45.0),
                topLeft: Radius.circular(0.0),
              )
            ),
          ),
        ),
      ),
    );
  }

}