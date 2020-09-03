import 'package:camel_up/models/post.dart';
import 'package:camel_up/utils/pref_keys.dart';
import 'package:camel_up/utils/pref_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostRepo {
  final _firestore = Firestore.instance;

  Future<void> savePostToFirestore() async{
    final docReference = _firestore.collection("posts").document();
    final postDetails = await PrefManager.getPostDetails();
    final postPrivacyDetails = await PrefManager.getPostPrivacyDetails();
    
    final id = docReference.documentID;
    final title = postDetails[PrefKeys.TITLE];
    final text = postDetails[PrefKeys.TEXT];
    final postKeyWords = postDetails[PrefKeys.KEYWORDS]?.cast<String>() ?? [];
    final privacy = postPrivacyDetails[PrefKeys.PRIVACY];
    final privacyList = postPrivacyDetails[PrefKeys.PRIVACY_LIST]?.cast<String>() ?? [];

    final post = Post(
      id: id,
      postKeywords: postKeyWords,
      title: title,
      text: text,
      privacy: privacy,
      privacyList: privacyList
    );

    return docReference.setData(post.toMap());
  }

  Future<List<Post>> getAllPosts() async{
    final snapshot = await _firestore.collection("posts").getDocuments();
    final postsList = snapshot.documents.map(
                      (doc) => Post.fromMap(doc.data)
                     ).toList();
    return postsList;                 
  }

  Future<List<Post>> getAllPostsForUser(String email) async{
    final snapshot = await _firestore.collection("posts")
                                .where("email", isEqualTo: email)
                                .getDocuments();
    final postsList = snapshot.documents.map(
                      (doc) => Post.fromMap(doc.data)
                     ).toList();
    return postsList;                 
  }

  Future<Post> getPostById(String id) async{
    final docSnapshot = await _firestore.collection("posts")
                                        .document(id).get();
   
    return Post.fromMap(docSnapshot.data);
  }

  Future<Post> getFirstUserPost(String email) async{
    final querySnapshot = await _firestore.collection("Post")
                                    .where("email", isEqualTo: email)
                                    .limit(1)
                                    .getDocuments();
                                    
    if(querySnapshot.documents.length > 0){
      final docSnapshot = querySnapshot.documents[0];   
      return Post.fromMap(docSnapshot.data);  
    } 
    else {
      return Post();
    }          
  }

  Future<void> toggleLikePost(String id) async{
    final snapshot = await _firestore.collection("posts").document(id).get();
    final post = Post.fromMap(snapshot.data);

    if(post.liked){
      await _firestore.collection("posts").document(id)
              .setData({"liked" : "false"}, merge: true);
      await updateLikesCount(postId: id, increment: false);
    }
    else {
      await _firestore.collection("posts").document(id)
              .setData({"liked" : "true"}, merge: true);
      await updateLikesCount(postId: id, increment: true);
    }
  }

  Future<String> getCommentsCount(String id) async{
    final ref = _firestore.collection("posts").document(id);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data);
    return post.commentsCount;
  }

  Future<String> getPostEvaluation({@required String evaluatorEmail, @required String postId}) async{
    final snapshot = await _firestore.collection("post_evaluations")
                .where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("postId", isEqualTo: postId)
                .getDocuments();
    final docs = snapshot.documents;
    return docs[0]["evaluation"].toString();
  }

  Future<String> getPostAverageEvaluation({@required String postId}) async{
    final snapshot = await _firestore.collection("posts").document(postId).get();
    return snapshot.data["averageEvaluation"].toString();
  }

  Future<void> updatePostAverageEvaluation({@required String postId, @required String evaluation}) async{
    final ref = _firestore.collection("posts").document(postId);
    final currentEvaluation = double.parse(await getPostAverageEvaluation(postId: postId));
    final int evalutationCount = await getCurrentEvaluationCount(postId);
    final newEvaluation = (currentEvaluation+(double.parse(evaluation)))/evalutationCount;
    await ref.setData({
      "evaluation" : newEvaluation.toString()
    }, merge: true);
  }

  Future<void> updatePostEvaluationCount({@required String postId}) async{
    final snapshot = await _firestore.collection("posts").document(postId).get();
    final currentEvaluationCount = int.parse(snapshot.data["evaluationCount"]);
    await _firestore.collection("posts").document(postId).setData({
      "evaluationCount" : (currentEvaluationCount+1)
    }, merge: true);
  }

  Future<int> getCurrentEvaluationCount(String postId) async{
    final snapshot = await _firestore.collection("posts").document(postId).get();
    return int.parse(snapshot.data["evaluationCount"]);
  }

  Future<void> savePostEvaluation({@required String evaluatorEmail, 
        @required String postId, @required String evaluation}) async{
    final ref = _firestore.collection("evaluations");
    final snapshot = await ref.where("evaluatorEmail", isEqualTo: evaluatorEmail)
                .where("postId", isEqualTo: postId)
                .getDocuments();

    final docs = snapshot.documents;
    if(docs.length >= 1) { //if already exists
      docs[0].reference.setData({
        "evaluation" : evaluation
      }, merge: true);
    }else {  //else
      ref.add({
        "evaluatorEmail" : evaluatorEmail,
        "postId" : postId,
        "evaluation" : evaluation
      });
    }
    updatePostEvaluationCount(postId: postId);
    updatePostAverageEvaluation(postId: postId, evaluation: evaluation);
  }

  Future<void> updateCommentCount({@required String postId, @required bool increment}) async{
    final ref = _firestore.collection("posts").document(postId);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data);
    final int currentCount = int.parse(post.commentsCount);
    if(increment){
      await ref.setData({"commentsCount" : (currentCount+1).toString()}, merge: true);
    }else{
      await ref.setData({"commentsCount" : (currentCount-1).toString()}, merge: true);
    }
  }

  Future<void> updateLikesCount({@required String postId, @required bool increment}) async{
    final ref = _firestore.collection("posts").document(postId);
    final snapshot = await ref.get();
    final idea = Post.fromMap(snapshot.data);
    final int currentCount = int.parse(idea.likesCount);
    if(increment){
      await ref.setData({"likesCount" : (currentCount+1).toString()}, merge: true);
    }else{
      await ref.setData({"likesCount" : (currentCount-1).toString()}, merge: true);
    }  
  }

  Future<String> getLikesCount(String id) async{
    final ref = _firestore.collection("posts").document(id);
    final snapshot = await ref.get();
    final post = Post.fromMap(snapshot.data);
    return post.likesCount;
  }

  Future<bool> getPostLikeStatus(String id) async{
    final snapshot = await _firestore.collection("posts").document(id).get();
    final post = Post.fromMap(snapshot.data);
    return post.liked;
  }
}