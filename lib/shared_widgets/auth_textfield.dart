import 'dart:ffi';

import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final double _radius = 30.0;

  AuthTextField({@required this.hint});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textFieldWidth = screenWidth * 0.8;

    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      alignment: Alignment.centerLeft,
      width: textFieldWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius)),
          color: AppColors.lightGrey),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        style: TextStyle(color: AppColors.darkGreyTextColor, fontSize: 20),
      ),
    );
  }
}
