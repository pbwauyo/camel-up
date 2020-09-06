import 'package:camel_up/models/comment.dart';
import 'package:camel_up/screens/idea_details/widgets/comment_footer.dart';
import 'package:camel_up/screens/the_idea/widgets/team_member_image.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget{
  final Comment comment;

  CommentCard({@required this.comment});

  @override
  Widget build(BuildContext context) {
   
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: AppColors.lightGrey,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: showImage(comment.commenterImageUrl),
                        fit: BoxFit.cover
                      )
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(comment.commenterName,
                          style: TextStyle(
                            color: Colors.black
                          ), 
                        ),
                      ),

                      // Container(
                      //   child: Text("A Einstein",
                      //     style: TextStyle(
                      //       color: Colors.black
                      //     ), 
                      //   ),
                      // ),
                      
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 200,
                        height: 1,
                        child: Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                        ),
                      )
                      
                    ],
                  )
                ],
              ),

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
                child: Text(comment.text,
                  style: TextStyle(
                    color: Colors.black
                  ), 
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 10,
          right: 10,
          bottom: -25,
          child: Center(
            child: CommentFooter(
              commentId: comment.id,
              liked: comment.liked,
            )
          )
        )
      ],
    );
  }
  
}