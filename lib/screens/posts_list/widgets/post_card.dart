import 'package:camel_up/models/post.dart';
import 'package:camel_up/screens/posts_list/widgets/post_card_footer.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget{
  final Post post;

  PostCard({@required this.post});

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
                        image: showImage(post.profileImage),
                        fit: BoxFit.fill
                      )
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(post.profileName,
                          style: TextStyle(
                            color: Colors.black
                          ), 
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 5),
                        child: Text("Move Immediately",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13
                          ), 
                        ),
                      ),
                      
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

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Text(post.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ), 
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
                child: Text(post.text,
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
            child: PostCardFooter(liked: post.liked, postId: post.id)
          )
        )
      ],
    );
  }  
}