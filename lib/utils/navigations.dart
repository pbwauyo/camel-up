import 'package:camel_up/screens/create_post/post_search_dialog.dart';
import 'package:camel_up/screens/privacy_list_dialog/privacy_list_dialog.dart';
import 'package:camel_up/shared_widgets/search_dialog.dart';
import 'package:flutter/material.dart';

class Navigations{

  static slideFromRight({@required BuildContext context, @required Widget newScreen}){
    final route = PageRouteBuilder(
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

    Navigator.of(context).push(route);
  }

  static popScreen(BuildContext context){
    Navigator.of(context).pop();
  }

  static goToSearchDialog(BuildContext context){
    Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      SearchDialog())
                );
  }

  static goToPrivacyListDialog(BuildContext context){
    Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      PrivacyListDialog())
                );
  }

   static goToPostPrivacyListDialog(BuildContext context){
    Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      PostSearchDialog())
                );
  }
}