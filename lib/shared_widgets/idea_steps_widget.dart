import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class IdeaStepsWidget extends StatelessWidget{
  final String number;
  final String title;

  IdeaStepsWidget({@required this.title, @required this.number});

  final double size = 50;
  final double fontSize = 25;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.yellow, width: 4),
            borderRadius: BorderRadius.circular(size/2)
          ),
          child: Center(
            child: Text(number,
              style: TextStyle(
                color: AppColors.lightGrey,
                fontWeight: FontWeight.bold,
                fontSize: fontSize
              ),
            ),
          ),
        ),

        Container(
          child: Text(title,
            style: TextStyle(
              color: AppColors.lightGrey,
              fontSize: fontSize
            ),
          ),
        )
      ],
    );
  }
}