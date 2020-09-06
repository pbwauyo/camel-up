import 'package:camel_up/models/idea.dart';
import 'package:camel_up/models/post.dart';
import 'package:camel_up/repos/idea_repo.dart';
import 'package:camel_up/repos/post_repo.dart';
import 'package:camel_up/screens/idea_details/widgets/idea_card.dart';
import 'package:camel_up/screens/posts_list/widgets/post_card.dart';
import 'package:camel_up/shared_widgets/custom_progress_indicator.dart';
import 'package:camel_up/shared_widgets/empty_results_text.dart';
import 'package:camel_up/shared_widgets/error_text.dart';
import 'package:camel_up/utils/colors.dart';
import 'package:flutter/material.dart';

class PostsList extends StatefulWidget{
  final String email;

  PostsList({@required this.email});

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final PostRepo _postsRepo = PostRepo();
  Future<List> postsFuture;

  @override
  void initState() {
    super.initState();
    postsFuture = _postsRepo.getAllPostsForUser(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: postsFuture,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data;
            if(data.length <= 0){
              return Center(child: EmptyResultsText(message: "No posts yet",));
            }
            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index){
                  return PostCard(post: data[index]);
                }
              ),
            );
          }else if(snapshot.hasError){
            return Center(child: ErrorText(error: snapshot.error));
          }

          return Center(child: CustomProgressIndicator());
        }
      );
  }
}