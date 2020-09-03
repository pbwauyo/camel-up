import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  UnderlinedText({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey,
            )
          )
        ),
        child: Text(text,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.lightGrey 
          ),
        ),
      ),
    );
  }
}