import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class Dot extends StatelessWidget{
  final Color color;
  final double _size = 10;

  Dot({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(_size/2)
      ),
    );
  }
}