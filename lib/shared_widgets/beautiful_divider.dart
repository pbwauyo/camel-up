import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class BeautifulDivider extends StatelessWidget{
  final double marginHorizontal;

  BeautifulDivider({this.marginHorizontal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 2,
              color: AppColors.lightGrey,
            )
          ),

          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.lightGrey
            ),
          ),

          Expanded(
            child: Container(
              height: 2,
              color: AppColors.lightGrey,
            )
          ),
        ],
      ),
    );
  }
}