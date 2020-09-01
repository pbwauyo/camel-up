import 'package:camel_up/repos/comment_repo.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class CommentFooter extends StatefulWidget {
  final String commentId;
  final bool liked;

  CommentFooter({@required this.commentId, @required this.liked});

  @override
  _CommentFooterState createState() => _CommentFooterState();
}

class _CommentFooterState extends State<CommentFooter> {
  final double size = 20;
  
  final _commentRepo = CommentRepo();
  bool _liked;
  Future<String> _likesCountFuture;
  Future<String> _commentsCountFuture;

  @override
  void initState() {
    super.initState();

    _liked = widget.liked;
    _likesCountFuture = _commentRepo.getLikesCount(widget.commentId);
    _commentsCountFuture = _commentRepo.getCommentsCount(widget.commentId);

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightGrey,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        width: 200,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: _liked ? BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  )
                ) : null,
                child: FutureBuilder<String>(
                  future: _likesCountFuture,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final likesCount = (snapshot.data == null || snapshot.data.length <= 0) ? 
                        "0" : snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AssetNames.LIKE),
                                fit: BoxFit.fill
                              )
                            ),
                          ),
                          Container(
                            child: Text(likesCount),
                          )
                        ],
                      );
                    }
                    return CustomProgressIndicator(
                      size: 15,
                    );
                  }
                ),
              ),
            ),

            Visibility(
              visible: !_liked,
              child: Container(
                height: 20,
                width: 1,
                color: Colors.black,
              ),
            ),

            Expanded(
              child: Container(
                child: FutureBuilder<String>(
                  future: _commentsCountFuture,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final commentsCount = (snapshot.data == null || snapshot.data.length <= 0) ? 
                        "0" : snapshot.data;
                      
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AssetNames.COMMENT_DOTS),
                                fit: BoxFit.fill
                              )
                            ),
                          ),
                          Container(
                            child: Text(commentsCount),
                          )
                        ],
                      );
                    }

                    return CustomProgressIndicator(
                      size: 15,
                    );
                    
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}