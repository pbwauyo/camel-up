import 'package:camel_up/repos/post_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class PostCardFooter extends StatefulWidget {
  final bool liked;
  final String postId;

  PostCardFooter({@required this.liked, @required this.postId});

  @override
  _PostCardFooterState createState() => _PostCardFooterState();
}

class _PostCardFooterState extends State<PostCardFooter> {
  
  final double size = 20;
  
  final _postsRepo = PostRepo();
  bool _liked;
  Future<String> _likesCountFuture;
  Future<String> _commentsCountFuture;
  bool _likeInProgress = false;

  @override
  void initState() {
    super.initState();

    _liked = widget.liked;
    _likesCountFuture = _postsRepo.getLikesCount(widget.postId);
    _commentsCountFuture = _postsRepo.getCommentsCount(widget.postId);

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
                      return GestureDetector(
                        onTap: _likeInProgress ? (){} : () async{
                          setState(() {
                              _likeInProgress = true;
                            });
                            try{
                              await _postsRepo.toggleLikePost(widget.postId);
                            }catch(error){
                              showCustomToast(error.message);
                            }
                            setState(() {
                              _likeInProgress = false;
                              _liked = !_liked;
                            });
                        },
                        child: Row(
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
                        ),
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