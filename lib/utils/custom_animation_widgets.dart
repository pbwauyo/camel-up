import 'package:flutter/cupertino.dart';

class CustomAnimationWidgets {

  static Widget slideFromRightWidget({@required Widget child, @required Animation<double> animation}){
    final begin = Offset(1, 0);
    final end = Offset(0, 0);
    final tween = Tween(begin: begin, end: end);
    final anim = tween.chain(CurveTween(curve: Curves.bounceIn));

    return SlideTransition(
      position: animation.drive(anim),
      child: child,
    );
  }
  
}