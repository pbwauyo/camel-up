import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget{
  final double size; 
  final Color borderColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final VoidCallback onTap;

  CircularButton({
    @required this.size, 
    @required this.borderColor,
    @required this.icon,
    @required this.iconSize,
    @required this.iconColor,
    @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(size/2),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(size/2),
        splashColor: Colors.black38,
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size/2),
            border: Border.all(
              color: borderColor,
              width: 3.5
            )
          ),
          child: Center(
            child: Icon(icon, 
              size: iconSize, 
              color: iconColor,
            ),
          )
        ),
      ),
    );
  }
}