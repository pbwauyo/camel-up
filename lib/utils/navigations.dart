import 'package:flutter/material.dart';

class Navigations{

  static Route slideFromRight({@required BuildContext context, @required Widget newScreen}){
    return PageRouteBuilder(
      pageBuilder: (context, anim, secondAnim){
        return newScreen;
      },
      transitionsBuilder: (context, anim, secondAnim, child){
        final begin = Offset(1.0, 0.0);
        final end = Offset(0.0, 0.0);
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeIn));
        final offsetAnim = anim.drive(tween); 

        return SlideTransition(
          position: offsetAnim,
          child: child,
        );
      }
      
    );
  }
}