import 'package:camel_up/models/comment.dart';
import 'package:camel_up/repos/comment_repo.dart';
import 'package:camel_up/repos/user_repo.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class CommentTextField extends StatefulWidget{
  final String ideaId;
  final String parentCommentId;

  CommentTextField({@required this.ideaId, this.parentCommentId});

  @override
  _CommentTextFieldState createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends State<CommentTextField> {
  final _userRepo = UserRepo();
  final _commnetRepo = CommentRepo();
  bool isPostingComment = false;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.lightGrey,
          ),
          width: screenWidth * 0.8,
          child: TextField(
            controller: _textController,
            enabled: !isPostingComment,
            decoration: InputDecoration(
              hintText: "Add your comment here..",
              border: InputBorder.none,
            ),
            cursorColor: AppColors.yellow,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) async{
              
              setState(() {
                isPostingComment = true;
              });

              try{
                
                final profile = await _userRepo.getCurrentUserProfile();
                final ideaId = widget.ideaId;
                final parentCommentId = widget.parentCommentId ?? "";
                final text = value;
                _textController.clear();
                final comment = Comment(
                  ideaId: ideaId,
                  commenterId: profile.email,
                  parentCommentId: parentCommentId,
                  text: text.trim(),
                  commenterName: "${profile.firstName} ${profile.lastName}",
                  commenterImageUrl: profile.profileImage
                );
              await _commnetRepo.postComment(comment);
              }catch(error){
                showCustomToast(error);
              }
              setState(() {
                isPostingComment = false;
              });
            },
          ),
        ),
      ),
    );
  }
}