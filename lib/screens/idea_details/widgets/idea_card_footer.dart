import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/utils/asset_names.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:camel_up/utils/methods.dart';
import 'package:flutter/material.dart';

class IdeaCardFooter extends StatefulWidget{
  final String ideaId;
  final bool liked;

  IdeaCardFooter({@required this.ideaId, @required this.liked});

  @override
  _IdeaCardFooterState createState() => _IdeaCardFooterState();
}

class _IdeaCardFooterState extends State<IdeaCardFooter> {
  final double _width = 160;
  final double _iconSize = 30;
  final IdeaRepo _ideaRepo = IdeaRepo();

  Future<String> _likesCountfuture;
  Future<String> _commentsCountFuture;
  bool _liked;
  bool _likeInProgress = false;

  @override
  void initState() {
    super.initState();

    _liked = widget.liked;

    _likesCountfuture = _ideaRepo.getLikesCount(widget.ideaId);
    _commentsCountFuture = _ideaRepo.getCommentsCount(widget.ideaId);

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
            width: _width,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: FutureBuilder<String>(
                    future: _commentsCountFuture,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final likesCount = (snapshot.data == null || snapshot.data.length <= 0) ? 
                        "0" : snapshot.data;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: _iconSize,
                              height: _iconSize,
                              margin: const EdgeInsets.only(right: 5.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AssetNames.COMMENT_DOTS),
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

                Container(
                  width: 80,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _liked ? AppColors.yellow : AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    )
                  ),
                  child: FutureBuilder<String>(
                    future: _likesCountfuture,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final commentsCount = (snapshot.data == null || snapshot.data.length <= 0) ? 
                        "0" : snapshot.data;
                        return GestureDetector(
                          onTap: _likeInProgress ? null :
                          () async{
                            setState(() {
                              _likeInProgress = true;
                            });
                            try{
                              await _ideaRepo.toggleLikeIdea(widget.ideaId);
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
                                width: _iconSize,
                                height: _iconSize,
                                margin: const EdgeInsets.only(right: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AssetNames.LIGHTBULB),
                                    fit: BoxFit.fill
                                  )
                                ),
                              ),

                              Container(
                                child: Text(commentsCount),
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
                ) 
              ],
            ),
          ),
    );
  }
}