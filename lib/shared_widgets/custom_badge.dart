import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget{
  final String text;
  final Color _color = AppColors.darkGreyTextColor;

  CustomBadge({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _color, width: 2.0)
      ),
      child: Text(text,
        style: TextStyle(
          color: _color
        ),
      ),
    );
  }
}