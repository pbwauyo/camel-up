import 'package:camel_up/shared_widgets/yellow_dot.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IdeaStepsWidgetAdvanced extends StatelessWidget{
  final String number;
  final String text;

  IdeaStepsWidgetAdvanced({@required this.text, @required this.number});

  final double size = 50;
  final double fontSize = 25;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Container(
          margin: const EdgeInsets.only(left: 20.0),
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

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: 4,
                      color: AppColors.yellow,
                    ),
                  ),
                  
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: YellowDot(size: 20)
                        ),
                        Container(
                          child: YellowDot(size: 20)
                        )
                      ],
                    ),
                  ),    
                ],
              ),

              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Text(text,
                  style: TextStyle(
                    fontSize: 35,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),

        
        
      ],
    );
  }
}